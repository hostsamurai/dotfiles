const path = require('path');
const fs = require('fs').promises;
const JSON5 = require('json5');

const getKeymapByMode = async () => {
  const filePath = path.resolve(
    __dirname,
    '../../../autoload/makyo/keymap.json5',
  );
  const keymap = await fs.readFile(filePath, 'utf8');
  const maps = JSON5.parse(keymap);

  return maps;
};

const getModeKeymapTuple = ([mode, keymap]) => {
  return Object.entries(keymap).map(([lhs, rhs]) => [mode, lhs, rhs]);
};

const createModeMaps = ([mode, lhs, rhs]) => `${mode} ${lhs} ${rhs}`;

const registerUserKeymap = plugin => {
  plugin.setOptions({dev: true, alwaysInit: true});

  plugin.registerFunction(
    'RegisterKeymap',
    async () => {
      try {
        const keymapByMode = await getKeymapByMode();

        Object.entries(keymapByMode)
          .filter(([, map]) => Object.keys(map).length)
          .flatMap(getModeKeymapTuple)
          .map(createModeMaps)
          .forEach(c => plugin.nvim.command(c));
      } catch (err) {
        console.error(err);
      }
    },
    {sync: false},
  );
};

module.exports = registerUserKeymap;
