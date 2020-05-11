const isObject = require('lodash.isobject')

/**
 * @private
 *
 * Constructs of a tuple for the given Vim mode and key map.
 *
 * @param {Array} entry
 * @param {string} entry.mode   - A Vim mode, such as nnoremap
 * @param {Object} entry.keymap - A map of keys to commands or configuration objects.
 * @return {Array}              - A mode, expression, and command to execute
 */
const getModeKeymapTuple = ([mode, keymap]) =>
  Object
    .entries(keymap)
    .filter(([, rhs]) => !isObject(rhs))
    .map(([lhs, rhs]) => [mode, lhs, rhs])


/**
 * @private
 *
 * Build a VimL expression that maps a mode to a command.
 *
 * @param {Array} tuple
 * @param {String} tuple.mode
 * @param {String} tuple.lhs
 * @param {String} tuple.rhs
 * @return {String} A VimL command
 */
const createModeMaps = ([mode, lhs, rhs]) => `${mode} ${lhs} ${rhs}`


/**
 * Create shortcuts for every key prefix mapped to simple expressions.
 *
 * @param {Object} plugin - A NeoVim remote plugin object instance.
 * @param {Object} keymapByMode - A map of modes to configurations.
 */
const mapSimpleKeymappings = (plugin, keymapByMode) =>
  Object
    .entries(keymapByMode)
    .filter(([, map]) => Object.keys(map).length)
    .flatMap(getModeKeymapTuple)
    .map(createModeMaps)
    .forEach(c => plugin.nvim.command(c))


module.exports = mapSimpleKeymappings
