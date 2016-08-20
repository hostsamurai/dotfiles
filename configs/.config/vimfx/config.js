'use strict'

const { utils: Cu } = Components;
const { require } = Cu.import('resource://gre/modules/commonjs/toolkit/require.js', {})


// Helper functions

const map = (name, keys) => {
  vimfx.set(`custom.mode.normal.${name}`, keys)
}

const jump = 0.25

const changeMediaProperty = (defaultArgs, prop, notification) => {
  const { vim, count } = defaultArgs
  const value = count * jump

  vimfx.send(vim, 'VimFx:custom:setMediaProperty', {
    property: prop,
    value,
    notification
  }, notificationString => vim.notify(notificationString))
}

const changeMediaPlaybackRate = defaultArgs => {
  changeMediaProperty(defaultArgs, 'playbackRate', 'Playback rate set to {playbackRate}')
}

const changeMediaVolume = defaultArgs => {
  changeMediaProperty(defaultArgs, 'volume', 'Volume set to {volume}')
}

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
  vim.window.gURLBar.value = `${keywords[searchType]} ${searchTerms}`
}

const createSearchCommand = (name, searchType, description) => {
  vimfx.addCommand({
    name,
    description,
    category: 'location',
    order: 1000
  }, args => setLocationBarSearch(Object.assign({}, args, { searchType })))
}


// Media shortcuts

vimfx.addCommand({
  name: 'media_loop_playing',
  description: 'Enable or disable looping media',
  category: 'misc',
  order: 10000
}, ({ vim }) => {
  vimfx.send(vim, 'VimFx:custom:toggleMediaLoop', {}, notificationString => vim.notify(notificationString))
})


vimfx.addCommand({
  name: 'media_decrease_playback_rate',
  description: 'Decrease the playback rate by 0.25',
  category: 'misc',
  order: 10000
}, ({ vim, count = 1 }) => changeMediaPlaybackRate({ vim, count: -count }))


vimfx.addCommand({
  name: 'media_increase_playback_rate',
  description: 'Increase the playback rate by 0.25',
  category: 'misc',
  order: 10000
}, ({ vim, count = 1 }) => changeMediaPlaybackRate({ vim, count }))


vimfx.addCommand({
  name: 'media_pause',
  description: 'Pauses the currently playing element',
  category: 'misc',
  order: 10000
}, ({ vim }) => vimfx.send(vim, 'VimFx:custom:pauseMediaElement'))


vimfx.addCommand({
  name: 'media_decrease_volume',
  description: 'Decrease the volume by 0.25',
  category: 'misc',
  order: 10000
}, ({ vim, count = 1 }) => changeMediaVolume({ vim, count: -count }))


vimfx.addCommand({
  name: 'media_increase_volume',
  description: 'Increase the volume by 0.25',
  category: 'misc',
  order: 10000
}, ({ vim, count = 1 }) => changeMediaVolume({ vim, count }))


// Tab shortcuts

vimfx.addCommand({
  name: 'tabs_find_first_playing',
  description: 'Finds the first tab containing a playing media element',
  category: 'tabs',
  order: 10000
}, ({ vim }) => {
  const { gBrowser, gBrowser: { tabs } } = vim.window
  const playing = Array.from(tabs).filter(t => t.soundPlaying)[0]

  playing && gBrowser.selectTabAtIndex(playing._tPos)
})


vimfx.addCommand({
  name: 'misc_set_search_engines',
  description: 'Set the order and keywords of the preferred search engines',
  category: 'misc',
  order: 10000
}, ({ vim }) => {
  const defaultEngines = Services.search.getEngines()
  const engineSettings = require(`${__dirname}/search_engine.js`)

  engineSettings.forEach((engine, i) => {
    const { search: s } = Services
    const nameChunk = new RegExp(engine.name)
    let e = defaultEngines.find(e => nameChunk.test(e.name))

    if (e && engine.remove) {
      s.removeEngine(e)
    } else if (e && engine.alias) {
      e.alias = engine.alias
      s.moveEngine(e, i)
    } else {
      s.addEngine(engine.url, 3, engine.icon, false, {
        onSuccess(newEngine) {
          newEngine.hidden = false
          newEngine.alias = engine.alias
          s.moveEngine(newEngine, i)
        },
        onError(error) {
          console.error(`Could not add search engine ${engine.name}`, error)
        }
      })
    }
  })
})


// Location bar search

createSearchCommand(
  'search_by_tabs',
  'tabs',
  'Search for text in any open tabs'
)

createSearchCommand(
  'search_by_page_title',
  'title',
  'Search for text that matches the title of a previously opened page'
)

createSearchCommand(
  'search_by_url',
  'url',
  'Search for text that matches part of a URL'
)

createSearchCommand(
  'search_by_history',
  'history',
  'Search for text that matches results from the browser\'s history'
)

createSearchCommand(
  'search_by_bookmarks',
  'bookmarks',
  'Search for text that matches any bookmarks'
)


// Misc

vimfx.addCommand({
  name: 'misc_save_to_pocket',
  description: 'Save current page to Pocket',
  category: 'misc',
  order: 10000
}, ({ vim }) => {
  const { window, window: { document: doc } } = vim
  const pocketButton = doc.getElementById('pocket-button')
  let iframe;

  const focusPanelInput = e => {
    const tagInput = e.target.getElementById('token-input-')
    const { focus: FS } = Services

    // focus the tag input
    FS.moveFocus(window, e.target.activeElement, FS.MOVEFOCUS_ROOT, FS.FLAG_BYMOUSE)
    FS.setFocus(tagInput, FS.MOVEFOCUS_CARET)

    iframe.removeEventListener('DOMContentLoaded', focusPanelInput, false)
  }

  const iframeObserver = {
    observe(newIframe) {
      Services.obs.removeObserver(this, 'document-element-inserted')

      iframe = doc.getElementById('PanelUI-pocketView').querySelector('iframe')
      iframe.addEventListener('DOMContentLoaded', focusPanelInput, false)
    }
  }

  if (!iframe) {
    Services.obs.addObserver(iframeObserver, 'document-element-inserted', false)
  }

  pocketButton.click()
})


vimfx.addCommand({
  name: 'misc_toggle_ublock',
  description: 'Toggle µBlock₀',
  category: 'misc',
  order: 10000
}, ({ vim }) => {
  const { window, window: { document, setTimeout } } = vim
  const ublockButton = document.getElementById('ublock0-button')
  let iframe

  const toggleUBlock = e => {
    const switchButton = e.target.getElementById('switch')
    const refreshButton = e.target.getElementById('refresh')

    setTimeout(() => {
      switchButton.click()
      refreshButton.click()
    }, 0)

    iframe.removeEventListener('DOMContentLoaded', toggleUBlock, false)
  }

  const iframeObserver = {
    observe(popup) {
      Services.obs.removeObserver(this, 'document-element-inserted')

      iframe = document.querySelector('#ublock0-panel').firstChild
      iframe.addEventListener('DOMContentLoaded', toggleUBlock, false)
    }
  }

  Services.obs.addObserver(iframeObserver, 'document-element-inserted', false)
  ublockButton.click()
})


// Mappings

map('media_loop_playing',           ',ml')
map('media_pause',                  '+mp')
map('media_decrease_playback_rate', '-mr')
map('media_increase_playback_rate', '+mr')
map('media_decrease_volume',        '-mv')
map('media_increase_volume',        '+mv')
map('tabs_find_first_playing',      'gmp')
map('misc_set_search_engines',      ',ms')
map('misc_save_to_pocket',          ',zp')
map('misc_toggle_ublock',           ',tu')
map('search_by_tabs',               ',st')
map('search_by_page_title',         ',sp')
map('search_by_url',                ',su')
map('search_by_history',            ',sh')
map('search_by_bookmarks',          ',sb')
