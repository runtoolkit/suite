'use strict';

/**
 * Hidden advancement used to mark "confirmed loaded" or to trigger a
 * reward function. Replaces nbt-data.com's "datapack item" field, but
 * functionally: instead of a minecraft:tick trigger we use
 * minecraft:impossible + a reward function, triggered manually via
 * `advancement grant` from another function.
 */
function buildAdvancement(ns, adv) {
  const json = {
    display: {
      icon: { id: adv.icon || 'minecraft:knowledge_book' },
      title: { text: adv.title || adv.path },
      description: { text: adv.description || '' },
      frame: 'task',
      show_toast: false,
      announce_to_chat: false,
      hidden: adv.hidden !== false,
    },
    criteria: {
      trigger: { trigger: 'minecraft:impossible' },
    },
  };
  if (adv.parent) json.parent = adv.parent;
  if (adv.reward_function) {
    json.rewards = { function: adv.reward_function };
  }
  return json;
}

function buildRecipe(ns, recipe) {
  if (recipe.type === 'shaped') {
    if (!recipe.pattern || !recipe.key) {
      throw new Error(
        `[${ns}:${recipe.path}] shaped recipe requires 'pattern' and 'key'`
      );
    }
    return {
      type: 'minecraft:crafting_shaped',
      pattern: recipe.pattern,
      key: recipe.key,
      result: { id: recipe.result, count: recipe.count || 1 },
    };
  }
  if (recipe.type === 'shapeless') {
    if (!recipe.ingredients || !recipe.ingredients.length) {
      throw new Error(
        `[${ns}:${recipe.path}] shapeless recipe requires 'ingredients'`
      );
    }
    return {
      type: 'minecraft:crafting_shapeless',
      ingredients: recipe.ingredients,
      result: { id: recipe.result, count: recipe.count || 1 },
    };
  }
  throw new Error(`Unknown recipe type: ${recipe.type}`);
}

function buildLootTable(ns, lt) {
  const poolType = {
    block: 'minecraft:block',
    chest: 'minecraft:chest',
    entity: 'minecraft:entity',
  }[lt.kind];
  if (!poolType) throw new Error(`Unknown loot table kind: ${lt.kind}`);

  return {
    type: poolType,
    pools: [
      {
        rolls: 1,
        entries: [
          {
            type: 'minecraft:item',
            name: lt.item,
            functions: lt.count && lt.count > 1
              ? [
                  {
                    function: 'minecraft:set_count',
                    count: lt.count,
                  },
                ]
              : undefined,
          },
        ],
      },
    ],
  };
}

/**
 * Macro function skeleton — 26.x $(param) syntax.
 * nbt-data.com has no macro/parameter support at all; this is the key
 * difference that lets the same function be called with different
 * parameters via `function ns:path with storage ns:temp path`.
 */
function macroFunctionSkeleton(path) {
  return [
    '# Macro function — parameters are injected via $(...).',
    '# Example call:',
    `#   $data modify storage ${'{{NAMESPACE}}'}:macro_io input set value {"example":"value"}`,
    `#   function ${'{{NAMESPACE}}'}:${path} with storage ${'{{NAMESPACE}}'}:macro_io input`,
    '',
    '$say Macro ran, parameter: $(example)',
  ].join('\n');
}

function plainFunctionSkeleton(path, commands) {
  if (commands && commands.length) return commands.join('\n');
  return `# ${path}\n# TODO: add commands here\n`;
}

function buildPredicate(ns, pred) {
  switch (pred.kind) {
    case 'random_chance':
      if (pred.chance === undefined) {
        throw new Error(`[${ns}:${pred.path}] random_chance predicate requires 'chance'`);
      }
      return { condition: 'minecraft:random_chance', chance: pred.chance };

    case 'entity_properties': {
      const predicate = {};
      if (pred.gamemode) predicate.gamemode = pred.gamemode;
      return {
        condition: 'minecraft:entity_properties',
        entity: pred.entity || 'this',
        predicate,
      };
    }

    case 'match_tool':
      if (!pred.item) {
        throw new Error(`[${ns}:${pred.path}] match_tool predicate requires 'item'`);
      }
      return {
        condition: 'minecraft:match_tool',
        predicate: { items: [pred.item] },
      };

    default:
      throw new Error(`Unknown predicate kind: ${pred.kind}`);
  }
}

function buildItemModifier(ns, mod) {
  switch (mod.kind) {
    case 'set_count': {
      if (mod.count === undefined && (mod.count_min === undefined || mod.count_max === undefined)) {
        throw new Error(
          `[${ns}:${mod.path}] set_count requires either 'count' or 'count_min'+'count_max'`
        );
      }
      const json = {
        function: 'minecraft:set_count',
        count:
          mod.count !== undefined
            ? mod.count
            : { type: 'minecraft:uniform', min: mod.count_min, max: mod.count_max },
      };
      if (mod.predicate_ref) json.conditions = [{ condition: 'minecraft:reference', name: mod.predicate_ref }];
      return json;
    }

    case 'enchant_randomly': {
      const json = { function: 'minecraft:enchant_randomly' };
      if (mod.enchantments && mod.enchantments.length) json.enchantments = mod.enchantments;
      if (mod.predicate_ref) json.conditions = [{ condition: 'minecraft:reference', name: mod.predicate_ref }];
      return json;
    }

    case 'set_name': {
      if (!mod.name) {
        throw new Error(`[${ns}:${mod.path}] set_name requires 'name'`);
      }
      const json = {
        function: 'minecraft:set_name',
        name: { text: mod.name },
        target: 'item_name',
      };
      if (mod.predicate_ref) json.conditions = [{ condition: 'minecraft:reference', name: mod.predicate_ref }];
      return json;
    }

    default:
      throw new Error(`Unknown item_modifier kind: ${mod.kind}`);
  }
}

/**
 * Minecraft has no native "dependency" field between datapacks (the
 * dependencies key in pack.mcmeta only applies to resource pack merging,
 * the datapack loader never reads it). The only reliable way to simulate
 * this is a load-function check, run after /reload, that looks for a
 * "sentinel" scoreboard value produced by the dependency's own namespace.
 *
 * The generated check function:
 *  - For each dependency, tries `execute unless score ... matches 1..`.
 *  - If missing, prints a red warning to players (instead of failing
 *    silently).
 *  - Dependencies with `required: false` only warn, they don't block
 *    anything further.
 *
 * For a dependent pack to satisfy this check, its own load function
 * needs `scoreboard objectives add dpgen_loaded dummy` and
 * `scoreboard players set <its-own-id> dpgen_loaded 1` — this is
 * generated automatically for the pack's own namespace (see builder.js).
 */
function buildDependencyCheckFunction(ownId, dependencies) {
  const lines = [
    '# Generated by dpgen — dependency check',
    'scoreboard objectives add dpgen_loaded dummy',
    `scoreboard players set ${ownId} dpgen_loaded 1`,
    '',
  ];

  for (const dep of dependencies) {
    const label = dep.version ? `${dep.id} (>= ${dep.version})` : dep.id;
    lines.push(
      `execute unless score ${dep.id} dpgen_loaded matches 1.. run tellraw @a ` +
        `{"text":"[dpgen] Missing dependency: ${label} — ${ownId} may not work as expected.","color":"red"}`
    );
    if (dep.required !== false) {
      lines.push(
        `execute unless score ${dep.id} dpgen_loaded matches 1.. run tellraw @a ` +
          `{"text":"[dpgen] ${label} is required, disabling ${ownId}.","color":"red"}`
      );
    }
  }

  return lines.join('\n');
}

module.exports = {
  buildAdvancement,
  buildRecipe,
  buildLootTable,
  buildPredicate,
  buildItemModifier,
  buildDependencyCheckFunction,
  macroFunctionSkeleton,
  plainFunctionSkeleton,
};
