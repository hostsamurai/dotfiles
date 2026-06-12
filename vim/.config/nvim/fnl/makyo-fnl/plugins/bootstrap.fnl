(import-macros {: module
                : def
                : defn}
               :nfnl.macros.aniseed)

(module makyo-fnl.plugins.bootstrap)

;; TODO: Remove this file
(defn bootstrap []
  "Bootstraps the lazy package manager and adds it to the runtime path."
  (let [lazypath (.. (vim.fn.stdpath "data") "/lazy/lazy.nvim")]
    (when (not (vim.loop.fs_stat lazypath))
      ;; Synchroneously clone the repo and place it in the right spot.
      (-> (vim.system ["git"
                       "clone"
                       "--filter=blob:none"
                       "https://github.com/folke/lazy.nvim.git"
                       "--branch=stable"
                       lazypath])
          (: :wait)))
    (vim.cmd.echo {:args ["\"rtp\""]})
    (vim.opt.rtp:prepend lazypath)))
