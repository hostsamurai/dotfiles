'use strict'

// Borrowed from LoDash's implementation for _.once
const before = (n, func) => {
  return (...args) => {
    let result
    if (--n > 0) {
      result = func.apply(this, args)
    }
    if (n <= 1) {
      func = undefined
    }
    return result
  }
}

module.exports.before = before
module.exports.once = func => before(2, func)
