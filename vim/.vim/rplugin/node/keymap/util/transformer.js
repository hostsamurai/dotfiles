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


module.exports = {objectToDict}
