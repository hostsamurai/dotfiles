/**
 * @private
 *
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
 * Turns a JS object into a string representing VimL Dict.
 *
 * @param {Object} obj
 * @return {string} A Dict in string form
 */
const objectToDict = obj => {
  let dict = ''

  try {
    dict = JSON.stringify(obj).replace(/"/g, '\'')
  } catch (e) {
    console.error(`Could not parse object: ${obj}`)
  }

  return dict
}


/**
 * Generates the VimL responsible for setting up a Dictionary of keys
 * mapped to descriptions. Dictionaries are only created if they don't
 * already exist.
 *
 * @param {string} parentKeys - A key path representing the parent of the current key.
 * @param {string} currentKey - The current key being processed.
 * @param {Object|Array} map  - An object storing the configuration of keys to descriptions.
 * @return {string} Generated VimL code for setting up a map of keys to descriptions.
 */
const getMapParent = (parentKeys, currentKey, map) => {
  const keys = parentKeys ? `${parentKeys}.${currentKey}` : currentKey
  const cmd = `
    let parentKeys = '${parentKeys}'

    if strlen(parentKeys) && !has_key(g:which_key_map[parentKeys], '${currentKey}')
      let g:which_key_map.${keys} = ${getGroupName(map)}
    elseif !strlen(parentKeys) && !has_key(g:which_key_map, '${currentKey}')
      let g:which_key_map['${currentKey}'] = ${getGroupName(map)}
    endif
  `

  return cmd
};


module.exports = {objectToDict, getMapParent}
