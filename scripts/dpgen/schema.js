'use strict';

// Minecraft 26.x pack.mcmeta constraints:
// - namespace: [a-z0-9_.-]+  (no uppercase, no spaces)
// - function/resource path: [a-z0-9_./-]+
//
// Since 25w31a, "pack_format" + "supported_formats" are replaced by
// "min_format" + "max_format" (a range). "pack_format" is optional
// and "supported_formats" is removed entirely in modern packs.
const NAMESPACE_RE = /^[a-z0-9_.-]+$/;
const PATH_RE = /^[a-z0-9_./-]+$/;
const ITEM_ID_RE = /^[a-z0-9_.-]+:[a-z0-9_./-]+$/;

const configSchema = {
  type: 'object',
  additionalProperties: false,
  required: ['pack', 'namespaces'],
  properties: {
    pack: {
      type: 'object',
      additionalProperties: false,
      required: ['name', 'description'],
      properties: {
        name: { type: 'string', minLength: 1, maxLength: 64 },
        description: { type: 'string', minLength: 1, maxLength: 256 },
        // min_format / max_format: current (26.x) range-based format fields.
        // Each accepts either a single integer or [major, minor].
        min_format: {
          anyOf: [
            { type: 'integer', minimum: 1 },
            { type: 'array', items: { type: 'integer', minimum: 0 }, minItems: 2, maxItems: 2 },
          ],
          default: 107,
        },
        max_format: {
          anyOf: [
            { type: 'integer', minimum: 1 },
            { type: 'array', items: { type: 'integer', minimum: 0 }, minItems: 2, maxItems: 2 },
          ],
          default: 107,
        },
        // Not part of vanilla pack.mcmeta — Minecraft has no native
        // dependency mechanism between datapacks. This is dpgen's own
        // build-time-checked, load-function-embedded convention
        // (see README "Dependencies").
        dependencies: {
          type: 'array',
          items: {
            type: 'object',
            additionalProperties: false,
            required: ['id'],
            properties: {
              id: { type: 'string', minLength: 1 },
              version: { type: 'string' },
              required: { type: 'boolean', default: true },
            },
          },
        },
      },
    },
    namespaces: {
      type: 'array',
      minItems: 1,
      items: {
        type: 'object',
        additionalProperties: false,
        required: ['id'],
        properties: {
          id: { type: 'string', pattern: NAMESPACE_RE.source },
          functions: {
            type: 'array',
            items: {
              type: 'object',
              additionalProperties: false,
              required: ['path'],
              properties: {
                path: { type: 'string', pattern: PATH_RE.source },
                commands: { type: 'array', items: { type: 'string' } },
                macro: { type: 'boolean', default: false },
                tick: { type: 'boolean', default: false },
                load: { type: 'boolean', default: false },
              },
            },
          },
          advancements: {
            type: 'array',
            items: {
              type: 'object',
              additionalProperties: false,
              required: ['path'],
              properties: {
                path: { type: 'string', pattern: PATH_RE.source },
                title: { type: 'string' },
                description: { type: 'string' },
                icon: { type: 'string', pattern: ITEM_ID_RE.source },
                parent: { type: 'string' },
                hidden: { type: 'boolean', default: true },
                reward_function: { type: 'string' },
              },
            },
          },
          recipes: {
            type: 'array',
            items: {
              type: 'object',
              additionalProperties: false,
              required: ['path', 'type'],
              properties: {
                path: { type: 'string', pattern: PATH_RE.source },
                type: { enum: ['shaped', 'shapeless'] },
                result: { type: 'string', pattern: ITEM_ID_RE.source },
                count: { type: 'integer', minimum: 1, default: 1 },
                pattern: { type: 'array', items: { type: 'string' } },
                key: { type: 'object' },
                ingredients: { type: 'array', items: { type: 'string' } },
              },
            },
          },
          loot_tables: {
            type: 'array',
            items: {
              type: 'object',
              additionalProperties: false,
              required: ['path', 'kind'],
              properties: {
                path: { type: 'string', pattern: PATH_RE.source },
                kind: { enum: ['block', 'chest', 'entity'] },
                item: { type: 'string', pattern: ITEM_ID_RE.source },
                count: { type: 'integer', minimum: 1, default: 1 },
              },
            },
          },
          predicates: {
            type: 'array',
            items: {
              type: 'object',
              additionalProperties: false,
              required: ['path', 'kind'],
              properties: {
                path: { type: 'string', pattern: PATH_RE.source },
                kind: { enum: ['random_chance', 'entity_properties', 'match_tool'] },
                chance: { type: 'number', minimum: 0, maximum: 1 },
                entity: { enum: ['this', 'killer', 'killer_player'], default: 'this' },
                gamemode: { enum: ['survival', 'creative', 'adventure', 'spectator'] },
                item: { type: 'string', pattern: ITEM_ID_RE.source },
              },
            },
          },
          item_modifiers: {
            type: 'array',
            items: {
              type: 'object',
              additionalProperties: false,
              required: ['path', 'kind'],
              properties: {
                path: { type: 'string', pattern: PATH_RE.source },
                kind: { enum: ['set_count', 'enchant_randomly', 'set_name'] },
                count: { type: 'integer', minimum: 1 },
                count_min: { type: 'integer', minimum: 1 },
                count_max: { type: 'integer', minimum: 1 },
                enchantments: { type: 'array', items: { type: 'string' } },
                name: { type: 'string' },
                predicate_ref: { type: 'string' },
              },
            },
          },
        },
      },
    },
  },
};

module.exports = { configSchema, NAMESPACE_RE, PATH_RE, ITEM_ID_RE };
