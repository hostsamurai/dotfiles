'use strict'

module.exports.observersWrapper = Services => {
  let observers = new Map()

  // Keep tabs on all observers. Enumerating them with
  // `Services.obs.enumerateObservers` doesn't seem to provide an easy
  // way of differentiating between them.
  const addObserver = (observer, topic) => {
    let topics = observers.get(observer) || []
    if (!topics.find(t => t === topic)) {
      Services.obs.addObserver(observer, topic, false)
      topics.push(topic)
      observers.set(observer, topics)
    }
  }

  const removeAllObservers = () => {
    // remove any observers that were manually set
    for (let [observer, topics] of observers.entries()) {
      topics.forEach(t => {
        Services.obs.removeObserver(observer, t)
      })
    }
  }

  return { addObserver, removeAllObservers }
}
