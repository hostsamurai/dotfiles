// Read JSON5 files through require()
require('json5/lib/register')

const keymapByMode = require('../../../autoload/makyo/keymap.json5')
const mapSimpleKeymappings = require('./keymaps/simple')
const mapWhichKeyCommands = require('./keymaps/which_key')


const registerUserKeymap = async plugin => {
  plugin.setOptions({dev: false, alwaysInit: false})

  await plugin.registerFunction(
    'RegisterKeymap',
    () => {
      mapSimpleKeymappings(plugin, keymapByMode)
      mapWhichKeyCommands(plugin, keymapByMode)
    },
    {sync: false}
  )

  await plugin.nvim.echoMsg('Finished setting up RegisterKeymap')
}

module.exports = registerUserKeymap
