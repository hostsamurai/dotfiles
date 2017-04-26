'use strict'


module.exports.searchCommandWrapper = vimfx => {
  const setLocationBarSearch = (args, ...searchTerms) => {
    const { commands } = vimfx.modes.normal
    const { searchType, vim } = args
    const keywords = {
      tabs:      '%',
      title:     '#',
      url:       '@',
      history:   '^',
      bookmarks: '*'
    }

    commands['focus_location_bar'].run(args)
    vim.window.gURLBar.value =
      keywords[searchType] ? `${keywords[searchType]} ${searchTerms}`
                           : `${searchType} `
  }

  const createSearchCommand = (name, searchType, description) => {
    vimfx.addCommand({
      name,
      description,
      category: 'location',
      order: 5000
    }, args => setLocationBarSearch(Object.assign({}, args, { searchType })))
  }

  const ddgBangSearch = (name, website, bang) => {
    vimfx.addCommand({
      name,
      description: `Search ${website}`,
      category: 'location',
      order: 5000
    }, args => setLocationBarSearch(Object.assign({}, args, { searchType: bang })))
  }

  return { createSearchCommand, ddgBangSearch }
}
