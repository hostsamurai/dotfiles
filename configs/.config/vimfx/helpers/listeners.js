'use strict'

module.exports.listenersWrapper = Services => {
  let listeners = new Map()

  // Adds an event handler to the target element and keeps a reference
  // of the added event.
  const addListener = (target, eventName, handler) => {
    let targetEvents = listeners.get(target)

    !targetEvents && (targetEvents = {})

    if (!targetEvents[eventName]) {
      target.addEventListener(eventName, handler, false)
      targetEvents[eventName] = handler
      listeners.set(target, targetEvents)
    }
  }

  const removeAllListeners = () => {
    // traverse listeners map, removing all events for each element
    for (let [element, events] of listeners.entries()) {
      Object.keys(events).forEach(eventName => {
        element.removeEventListener(eventName, events[eventName], false)
      })
    }
  }

  return { addListener, removeAllListeners }
}
