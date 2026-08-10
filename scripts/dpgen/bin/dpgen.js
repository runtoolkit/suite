#!/usr/bin/env node
'use strict';

const fs = require('fs');
const path = require('path');
const yaml = require('js-yaml');
const archiver = require('archiver');
const { buildFileMap, ConfigError } = require('../builder');

function usage() {
  console.error(
    [
      'Usage:',
      '  dpgen build <config.yaml|config.json> [-o output.zip]',
      '  dpgen validate <config.yaml|config.json>',
    ].join('\n')
  );
}

function loadConfig(file) {
  const raw = fs.readFileSync(file, 'utf8');
  if (file.endsWith('.json')) return JSON.parse(raw);
  return yaml.load(raw);
}

function writeZip(fileMap, outPath) {
  return new Promise((resolve, reject) => {
    const output = fs.createWriteStream(outPath);
    const archive = archiver('zip', { zlib: { level: 9 } });

    output.on('close', () => resolve(archive.pointer()));
    archive.on('warning', (err) => {
      if (err.code !== 'ENOENT') reject(err);
    });
    archive.on('error', reject);

    archive.pipe(output);

    for (const [relPath, content] of Object.entries(fileMap)) {
      const data =
        typeof content === 'string' ? content : JSON.stringify(content, null, 2);
      archive.append(data, { name: relPath });
    }

    archive.finalize();
  });
}

async function main() {
  const [cmd, configPath, ...rest] = process.argv.slice(2);

  if (!cmd || !configPath) {
    usage();
    process.exit(1);
  }

  let config;
  try {
    config = loadConfig(configPath);
  } catch (err) {
    console.error(`Failed to read config: ${err.message}`);
    process.exit(1);
  }

  if (cmd === 'validate') {
    try {
      buildFileMap(config); // validation also runs inside build
      console.log('OK — config is valid.');
    } catch (err) {
      if (err instanceof ConfigError) {
        console.error(err.message);
        process.exit(1);
      }
      throw err;
    }
    return;
  }

  if (cmd === 'build') {
    let outPath = `${config.pack?.name || 'datapack'}.zip`;
    const oIdx = rest.indexOf('-o');
    if (oIdx !== -1 && rest[oIdx + 1]) outPath = rest[oIdx + 1];

    let fileMap;
    try {
      fileMap = buildFileMap(config);
    } catch (err) {
      if (err instanceof ConfigError) {
        console.error(err.message);
        process.exit(1);
      }
      throw err;
    }

    const bytes = await writeZip(fileMap, path.resolve(outPath));
    console.log(`Written: ${outPath} (${bytes} bytes, ${Object.keys(fileMap).length} files)`);
    return;
  }

  usage();
  process.exit(1);
}

main().catch((err) => {
  console.error(err.stack || err.message);
  process.exit(1);
});
