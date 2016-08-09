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
  name: 'tabs_save_to_pocket',
  description: 'Save to Pocket',
  category: 'tabs',
  order: 10000
}, ({ vim }) => {
  const { window, window: { content: { document } } } = vim
  window.Pocket.savePage(vim.browser, document.location.href, document.title)
  // TODO: How to autofocus the input element inside the Pocket menu?
})


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


// Mappings

map('media_loop_playing',           ',ml')
map('media_pause',                  '+mp')
map('media_decrease_playback_rate', '-mr')
map('media_increase_playback_rate', '+mr')
map('media_decrease_volume',        '-mv')
map('media_increase_volume',        '+mv')
map('tabs_save_to_pocket',          'gsp')
map('tabs_find_first_playing',      'gmp')
map('misc_set_search_engines',      ',ms')
