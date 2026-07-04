;;;; ----------------------------------------------------------------------

;;;; (魔境 makyō) - a Zen term meaning "ghost cave" or "devil's cave", a
;;;; perfect description of Vim configuration

;;;; ----------------------------------------------------------------------


;;; ---------------------------------------------
;;; MODULE VARIABLES
;;; ---------------------------------------------


(local lazy-base-path (.. (vim.fn.stdpath "data") "/lazy"))
(local lazy-path (.. lazy-base-path "/lazy.nvim"))
(local nfnl-path (.. lazy-base-path "/nfnl"))
(local nvim-lua-path (.. lazy-base-path "/nvim.lua"))
(local nvim-config-path (.. (vim.fn.stdpath "config")))

(local makyo-start-augroup (vim.api.nvim_create_augroup "makyo.startup" {:clear true}))


;;; ---------------------------------------------
;;; HELPER FUNCTIONS
;;; ---------------------------------------------


(fn lazy-exists? []
  (pcall require "lazy"))

(fn is-nfnl-installed? []
  (pcall require "nfnl.core"))

(fn quit-neovim []
  (vim.api.nvim_cmd {:cmd "quit!"} {}))

(fn start-makyo []
  (require :makyo-fnl.init))

(fn plugins-already-installed? []
  (let [dir-count (length (vim.fn.globpath lazy-base-path "*" 0 1))]
    (> dir-count 4)))


;;; ---------------------------------------------
;;; BOOTSTRAP FUNCTIONS
;;; ---------------------------------------------


(fn bootstrap-lazy []
  "Bootstraps the lazy package manager and adds it to the runtime path."
  (let [lazy-path (.. (vim.fn.stdpath "data") "/lazy/lazy.nvim")]
    (when (not (vim.uv.fs_stat lazy-path))
      ;; Synchroneously clone the repo and place it in the right spot.
      (-> (vim.system [
                       "git"
                       "clone"
                       "--filter=blob:none"
                       "https://github.com/folke/lazy.nvim.git"
                       "--branch=stable"
                       lazy-path
                       ])
          (: :wait)))
    (vim.opt.rtp:prepend lazy-path)))

(fn restore-plugins []
  "This is a 3-step process that initializes Makyo by making sure that
  all of its source files are transpiled to Lua ones and by ensuring
  that Lazy is setup correctly. The first two steps are meant to be run
  in headless mode."
  (let [lazy (require :lazy)]
    ;; NOTE: "Olical/nfnl" and "norcalli/nvim.lua" are essential to
    ;; our configuration and must be installed first.
    (vim.opt.rtp:prepend nfnl-path)
    ;; TODO: Remove nvim.lua entirely
    (vim.opt.rtp:prepend nvim-lua-path)

    (when (not (is-nfnl-installed?))
      ;; Install essential plugins
      (lazy.setup {:spec ["Olical/nfnl" "norcalli/nvim.lua"]})
      (vim.print "[makyo] 🔌 Successfully installed core plugins. Restart to compile all files.")
      (quit-neovim))

   (when (not (plugins-already-installed?))
     ;; Compile all of the Fennel source files
     (vim.api.nvim_exec2 (.. "NfnlCompileAllFiles " nvim-config-path) {:output true})
     (vim.print "[makyo] 🔌 Compilation completed successfully. Restoring all plugins...")
     ;; Restore the Lazy lockfile back to what it was.
     (vim.system [
                   "git"
                   "restore"
                   (.. nvim-config-path "lazy-lock.json")
                   ])
      ;; Restore all plugins
      (vim.system ["Lazy" "restore"])
      (vim.print "[makyo] 🔌 Restart to get the full Makyo experience...")
      (quit-neovim))

    (when (plugins-already-installed?)
      ;; Register all specs
      (lazy.setup "makyo-fnl.plugins.lazy.plugins")
      ;; Fire the `LazyDone` event from Lazy to signal that we're
      ;; ready to start with the rest of the initialization.
      ;; NOTE: This has to be done here and not before we register all
      ;; specs. Otherwise, we experience breakage for certain plugins
      ;; which are not ready at the time that we try to configure them
      ;; separately.
      (vim.api.nvim_exec_autocmds [:User] {:group makyo-start-augroup :pattern "LazyDone"})
      (vim.print "[makyo] 🔌 Plugins setup completed."))))

(fn prepare-lazy-done-hook []
  "Creates the `autocmd` that will kick off Makyo's init process."
  (let [startup-augroup makyo-start-augroup]
    (vim.api.nvim_create_autocmd ["User"]
                                 {
                                   :group startup-augroup
                                   :pattern "LazyDone"
                                   :callback start-makyo
                                   })))


;;; ---------------------------------------------
;;; INIT
;;; ---------------------------------------------


;; NOTE: The initialization process can be broken down into the
;; following steps:
;;
;; 1. Bootstrap Lazy
;; 2. Compile all of the Fennel source code so that we can run this
;;    setup. It is assumed that the `lua/makyo-fnl` directory does not
;;    exist. For the compilation, we need `nfnl` installed at a
;;    minimum, so we override our Lazy spec to include it. Once
;;    installed, we can then run the compilation.
;; 3. We revert our changes to our Lazy spec to get the full list of
;;    plugins we must restore, and then we do just that.
;; 4. The user can then start Makyo and get the enhanced Neovim
;;    experience.
;;
;; It is better to run those first three steps in headless mode via
;; `nvim --headless`. Once we get the verification that all of the
;; plugins have been restored, then we can open Neovim in a GUI.

(fn init []
  (do
    (bootstrap-lazy)
    (prepare-lazy-done-hook)
    (restore-plugins)))

(init)
