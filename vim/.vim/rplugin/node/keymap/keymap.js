// Read JSON5 files through require()
require('json5/lib/register')

const keymapByMode = require('../../../autoload/makyo/keymap.json5')
const mapSimpleKeymappings = require('./keymaps/simple')
const mapWhichKeyCommands = require('./keymaps/which_key')


const registerUserKeymap = plugin => {
  plugin.setOptions({dev: true, alwaysInit: true})

  plugin.registerFunction(
    'RegisterKeymap',
    () => {
      mapSimpleKeymappings(plugin, keymapByMode)
      mapWhichKeyCommands(plugin, keymapByMode)
    },
    {sync: true}
  )
}

module.exports = registerUserKeymap
