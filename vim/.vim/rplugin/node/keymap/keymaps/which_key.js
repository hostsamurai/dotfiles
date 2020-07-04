const isObject = require("lodash.isobject")
const { objectToDict, getMapParent } = require("../util/transformer")


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
  const mapParent = getMapParent(keyPrefix, key, map)
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
            `let g:which_key_map.${keys}['${k}'] = '${desc}'`
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

  modes.forEach(m => {
    Object
      .entries(keymapByMode[m])
      .filter(([, cmdOrMap]) => isObject(cmdOrMap))
      .reduce((commands, [key, keymap]) => {
        const scopedCommands = assignMap(m, key, keymap)
        return scopedCommands.length ? commands.concat(scopedCommands) : commands
      }, [])
      .map(c => {
        console.log(c)
        plugin
          .nvim
          .command(c)
          .catch(e => console.error({error: e, vimCmd: c}))
      })
  })
}


module.exports = mapWhichKeyCommands
