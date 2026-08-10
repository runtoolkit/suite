'use strict';

const Ajv = require('ajv');
const { configSchema, NAMESPACE_RE, PATH_RE } = require('./schema');
const {
  buildAdvancement,
  buildRecipe,
  buildLootTable,
  buildPredicate,
  buildItemModifier,
  buildDependencyCheckFunction,
  macroFunctionSkeleton,
  plainFunctionSkeleton,
} = require('./templates');

const ajv = new Ajv({ useDefaults: true, allErrors: true });
const validate = ajv.compile(configSchema);

class ConfigError extends Error {}

// min_format/max_format accept either a plain integer or [major, minor].
// For range-sanity checks we only need the major component.
function majorOf(formatValue) {
  return Array.isArray(formatValue) ? formatValue[0] : formatValue;
}

function validateConfig(config) {
  const valid = validate(config);
  if (!valid) {
    const msgs = validate.errors.map(
      (e) => `${e.instancePath || '(root)'} ${e.message}`
    );
    throw new ConfigError('Config validation failed:\n' + msgs.join('\n'));
  }

  // Checks beyond what Ajv can express: name collisions, min/max_format ordering.
  const seenNs = new Set();
  for (const ns of config.namespaces) {
    if (seenNs.has(ns.id)) {
      throw new ConfigError(`Duplicate namespace: ${ns.id}`);
    }
    seenNs.add(ns.id);

    const seenFn = new Set();
    for (const fn of ns.functions || []) {
      if (seenFn.has(fn.path)) {
        throw new ConfigError(`[${ns.id}] duplicate function path: ${fn.path}`);
      }
      seenFn.add(fn.path);
    }
  }

  const minF = majorOf(config.pack.min_format ?? 107);
  const maxF = majorOf(config.pack.max_format ?? 107);
  if (minF > maxF) {
    throw new ConfigError(
      `min_format (${minF}) cannot be greater than max_format (${maxF})`
    );
  }

  return config;
}

/**
 * Converts config into a flat { "relative/path": "content-string-or-object" }
 * file map. Objects are JSON.stringify'd at archive time.
 */
function buildFileMap(config) {
  validateConfig(config);
  const files = {};
  const pack = config.pack;

  // Since 25w31a, pack.mcmeta uses min_format/max_format (a range) instead
  // of the old pack_format + supported_formats pair. Both fields accept
  // either a single integer or [major, minor]. Defaulting both to 107
  // keeps a single fixed-format pack working exactly like the old
  // pack_format: 107 did.
  files['pack.mcmeta'] = {
    pack: {
      min_format: pack.min_format ?? 107,
      max_format: pack.max_format ?? 107,
      description: pack.description,
    },
  };

  // Tick/load functions collected across all namespaces — the
  // minecraft:tick / minecraft:load tags support multiple functions via
  // a "values" array; nbt-data.com assumes a single function, we merge
  // whatever each namespace contributes.
  const tickValues = [];
  const loadValues = [];

  // Collect all known predicates up front so item_modifiers can validate
  // predicate_ref against them — referencing an undefined predicate should
  // fail at build time, not produce silently broken JSON.
  const knownPredicates = new Set();
  for (const ns of config.namespaces) {
    for (const pred of ns.predicates || []) {
      knownPredicates.add(`${ns.id}:${pred.path}`);
    }
  }

  for (const ns of config.namespaces) {
    if (!NAMESPACE_RE.test(ns.id)) {
      throw new ConfigError(`Invalid namespace: ${ns.id}`);
    }
    const base = `data/${ns.id}`;

    for (const fn of ns.functions || []) {
      if (!PATH_RE.test(fn.path)) {
        throw new ConfigError(`[${ns.id}] invalid function path: ${fn.path}`);
      }
      const fullId = `${ns.id}:${fn.path}`;
      const content = fn.macro
        ? macroFunctionSkeleton(fn.path).replace(/{{NAMESPACE}}/g, ns.id)
        : plainFunctionSkeleton(fn.path, fn.commands);

      files[`${base}/function/${fn.path}.mcfunction`] = content;

      if (fn.tick) tickValues.push(fullId);
      if (fn.load) loadValues.push(fullId);
    }

    for (const adv of ns.advancements || []) {
      files[`${base}/advancement/${adv.path}.json`] = buildAdvancement(ns.id, adv);
    }

    for (const recipe of ns.recipes || []) {
      files[`${base}/recipe/${recipe.path}.json`] = buildRecipe(ns.id, recipe);
    }

    for (const lt of ns.loot_tables || []) {
      files[`${base}/loot_table/${lt.path}.json`] = buildLootTable(ns.id, lt);
    }

    for (const pred of ns.predicates || []) {
      files[`${base}/predicate/${pred.path}.json`] = buildPredicate(ns.id, pred);
    }

    for (const mod of ns.item_modifiers || []) {
      if (mod.predicate_ref && !knownPredicates.has(mod.predicate_ref)) {
        throw new ConfigError(
          `[${ns.id}:${mod.path}] predicate_ref '${mod.predicate_ref}' is not defined`
        );
      }
      files[`${base}/item_modifier/${mod.path}.json`] = buildItemModifier(ns.id, mod);
    }
  }

  // Dependency check: if pack.dependencies is set, generate an automatic
  // __dpgen_deps.mcfunction in the first namespace and hook it into load.
  if (pack.dependencies && pack.dependencies.length) {
    const ownId = config.namespaces[0].id;
    const depFnPath = `data/${ownId}/function/__dpgen_deps.mcfunction`;
    files[depFnPath] = buildDependencyCheckFunction(ownId, pack.dependencies);
    loadValues.unshift(`${ownId}:__dpgen_deps`);
  }

  if (tickValues.length) {
    files['data/minecraft/tags/function/tick.json'] = { values: tickValues };
  }
  if (loadValues.length) {
    files['data/minecraft/tags/function/load.json'] = { values: loadValues };
  }

  return files;
}

module.exports = { buildFileMap, validateConfig, ConfigError };
