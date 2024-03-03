(module makyo-fnl.plugins.bootstrap
  {require {a aniseed.core
            nvim aniseed.nvim}})

(defn bootstrap []
  "Bootstraps the lazy package manager and adds it to the runtime path."
  (let [lazypath (.. (nvim.fn.stdpath "data") "/lazy/lazy.nvim")]
    (when (not (vim.loop.fs_stat lazypath))
      (nvim.fn.system ["git"
                       "clone"
                       "--filter=blob:none"
                       "https://github.com/folke/lazy.nvim.git"
                       "--branch=stable"
                       lazypath]))
    (set nvim.o.rtp (.. lazypath "," nvim.o.rtp))))
