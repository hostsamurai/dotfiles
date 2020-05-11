const isObject = require("lodash.isobject")
const { objectToDict } = require("../util/transformer")


/**
 * Turns an object representing a Vim mapping into a Dictionary.
 *
 * @param {Object} map - A two-element array.
 * @return {string}    - A string denoting a VimL dictionary.
 */
const getGroupName = map =>  {
  const descEntry = Object.entries(map)[0]
  const descObj = Object.fromEntries([descEntry])

  return objectToDict(descObj)
}


/**
 * @private
 *
 * Assigns a JS object as a dictionary to `which_key`.
 *
 * @param {string} mode      - A Vim mode
 * @param {string} key       - A one-letter key value.
 * @param {Object|Array} map - An object with commands and their descriptions.
 * @param {string} keyPrefix - For nested mappings, this represents the parent key of the mapping.
 * @return {Array}           - Vim commands for configuring which_key.
 */
const assignMap = (mode, key, map, keyPrefix = '') => {
  const keys = keyPrefix ? `${keyPrefix}.${key}` : key
  const mapParent = `let g:which_key_map.${keys} = ${getGroupName(map)}`
  const entries = isObject(map) ? Object.entries(map) : map

  const commands =
    entries
      .filter(([k]) => k !== 'name')
      .reduce((mapCmds, [k, cmdInfoOrNestedMap]) => {
        let cmds

        if (Array.isArray(cmdInfoOrNestedMap)) {
          const [rhs, desc] = cmdInfoOrNestedMap
          cmds = [
            `${mode} <silent> <leader>${keys.replace('.', '')}${k} ${rhs}`,
            `let g:which_key_map.${keys}["${k}"] = '${desc}'`
          ]
        } else {
          cmds = assignMap(mode, k, cmdInfoOrNestedMap, keys)
        }

        return mapCmds.concat(cmds)
      }, [mapParent])

  return commands
}


/**
 * Runs through a list of commands to map key prefixes to configuration
 * mappings for registering with which_key.
 *
 * @param {Object} plugin       - A NeoVim remote plugin object instance.
 * @param {Object} keymapByMode - Mappings for each mode.
 */
const mapWhichKeyCommands = (plugin, keymapByMode) => {
  const modes =
    Object
      .keys(keymapByMode)
      .filter(m => m === 'nnoremap' || m === 'noremap' || m === 'map')

  // Initialize which_key_map
  plugin.nvim.command("let g:which_key_map = {}")

  modes.forEach(m => {
    Object
      .entries(keymapByMode[m])
      .filter(([, cmdOrMap]) => isObject(cmdOrMap))
      .reduce((commands, [key, keymap]) => {
        const scopedCommands = assignMap(m, key, keymap)
        return scopedCommands.length ? commands.concat(scopedCommands) : commands
      }, [])
      .map(c =>
        plugin
          .nvim
          .command(c)
          .catch(e => console.error({error: e, vimCmd: c}))
      )
  })
}


module.exports = mapWhichKeyCommands
