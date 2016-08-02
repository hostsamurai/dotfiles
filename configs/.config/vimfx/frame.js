'use strict'


const getMediaElement = () => content.document.querySelector('video, audio')


/**
 * Sets a specific property of any active video or audio element.
 *
 * @param {Object} opts
 *   Options needed to operate on said element. These include:
 *
 *   property:
 *     The property to set on the media element, e.g. `playbackRate`.
 *   value:
 *     What to set the media property to.
 *   notification:
 *     A pseudo-template string containing the message to display as a
 *     notification when the media property is successfully set.
 */
const setMediaProperty = opts => {
  const {
    property: prop,
    value,
    notification
  } = opts
  const media = getMediaElement()

  if (media) {
    const property = media[prop]
    const newValue = property + value

    // Volume must be a value between 0 and 1; playback rate
    // must be greater than 0.
    media[prop] = prop === 'volume'
      ? newValue <= 1 ? Math.max(newValue, 0) : 1
      : Math.max(newValue, 0)

    if (prop === 'volume' && media[prop]) {
      media.muted = false
    }

    return notification.replace(`{${prop}}`, media[prop])
  }
}


vimfx.listen('VimFx:custom:setMediaProperty', (opts, callback) => {
  const notification = setMediaProperty(opts)
  callback(notification)
})


vimfx.listen('VimFx:custom:toggleMediaLoop', (opts, callback) => {
  const media = getMediaElement()

  if (media) {
    media.loop = !media.loop
    callback(media.loop ? 'Looping enabled' : 'Disabled looping')
  }
})


vimfx.listen('VimFx:custom:pauseMediaElement', () => {
  const media = getMediaElement()
  media.paused ? media.play() : media.pause()
})
