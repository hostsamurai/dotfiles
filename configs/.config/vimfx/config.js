'use strict'

const { utils: Cu } = Components;
const { require } = Cu.import('resource://gre/modules/commonjs/toolkit/require.js', {})

// TODO: use a loader here
const { once } = require(`file://${__dirname}/helpers/fn.js`)
const { searchCommandWrapper } = require(`file://${__dirname}/helpers/search.js`)
const { listenersWrapper } = require(`file://${__dirname}/helpers/listeners.js`)
const { observersWrapper } = require(`file://${__dirname}/helpers/observers.js`)

const createSearchCommand = searchCommandWrapper(vimfx)
const { addListener, removeAllListeners } = listenersWrapper(Services)
const { addObserver, removeAllObservers } = observersWrapper(Services)


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

const scrollTabScrollbox = (vim, amount) => {
  const { window: { gBrowser } } = vim
  const scrollbox = gBrowser.tabContainer.mTabstrip._scrollbox
  scrollbox.scrollLeft += amount
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
  name: 'tabs_scroll_scrollbox_left',
  description: 'Scroll the tabs scrollbox to the left',
  category: 'tabs',
  order: 10000
}, ({ vim, count = 1 }) => scrollTabScrollbox(vim, -200 * count))


vimfx.addCommand({
  name: 'tabs_scroll_scrollbox_right',
  description: 'Scroll the tabs scrollbox to the right',
  category: 'tabs',
  order: 10000
}, ({ vim, count = 1 }) => scrollTabScrollbox(vim, 200 * count))


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

const addPocketIframeObserver = once(addObserver)

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
  }

  const iframeObserver = {
    observe(newIframe) {
      iframe = doc.getElementById('PanelUI-pocketView').querySelector('iframe')
      addListener(iframe, 'DOMContentLoaded', focusPanelInput)
    }
  }

  addPocketIframeObserver(iframeObserver, 'document-element-inserted')

  pocketButton.click()
})


const addUblockIframeObserver = once(addObserver)

vimfx.addCommand({
  name: 'misc_toggle_ublock',
  description: 'Toggle µBlock₀',
  category: 'misc',
  order: 10000
}, ({ vim }) => {
  const { window, window: { document, setTimeout } } = vim
  const ublockButton = document.getElementById('ublock0-button')

  const toggleUBlock = e => {
    const switchButton = e.target.getElementById('switch')
    const refreshButton = e.target.getElementById('refresh')

    setTimeout(() => {
      switchButton && switchButton.click()
      refreshButton && refreshButton.click()
    }, 0)
  }

  const iframeObserver = {
    observe(popup) {
      const iframe = document.querySelector('#ublock0-panel').firstChild
      addListener(iframe, 'DOMContentLoaded', toggleUBlock)
    }
  }

  addUblockIframeObserver(iframeObserver, 'document-element-inserted')
  ublockButton.click()
})


vimfx.addCommand({
  name: 'misc_toggle_sync_tabs_menu',
  description: 'Display the synced tabs menu',
  category: 'misc',
  order: 10000
}, ({ vim }) => {
  const { window, window: { document, SidebarUI } } = vim
  const { browser } = SidebarUI

  const sidebarLoaded = e => {
    if (/sidebar\.xhtml$/.test(e.target.URL)) {
      SidebarUI._fireFocusedEvent()
    }
  }

  addListener(browser, 'DOMContentLoaded', sidebarLoaded)
  SidebarUI.toggle('viewTabsSidebar')
})


// Events

vimfx.on('shutdown', () => {
  removeAllListeners()
  removeAllObservers()
})


// Mappings

map('media_loop_playing',           ',ml')
map('media_pause',                  '+mp')
map('media_decrease_playback_rate', '-mr')
map('media_increase_playback_rate', '+mr')
map('media_decrease_volume',        '-mv')
map('media_increase_volume',        '+mv')
map('tabs_find_first_playing',      'gmp')
map('tabs_scroll_scrollbox_right',  ',tr')
map('tabs_scroll_scrollbox_left',   ',tl')
map('misc_set_search_engines',      ',ms')
map('misc_save_to_pocket',          ',zp')
map('misc_toggle_ublock',           ',tu')
map('misc_toggle_sync_tabs_menu',   ',tt')
map('search_by_tabs',               ',st')
map('search_by_page_title',         ',sp')
map('search_by_url',                ',su')
map('search_by_history',            ',sh')
map('search_by_bookmarks',          ',sb')
