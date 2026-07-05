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
(local nvim-config-lua-path (.. nvim-config-path "/lua"))
(local nvim-fnl-path (.. nvim-config-path "/fnl"))

(local makyo-start-augroup (vim.api.nvim_create_augroup "makyo.startup" {:clear true}))


;;; ---------------------------------------------
;;; HELPER FUNCTIONS
;;; ---------------------------------------------


(fn lazy-exists? []
  (pcall require "lazy"))

(fn is-installed? [module]
  (pcall require module))

(fn restart-neovim []
  (vim.api.nvim_cmd {:cmd "restart" :args [":qall!"]} {}))

(fn quit-neovim []
  (vim.api.nvim_cmd {:cmd "q"} {}))

(fn start-makyo []
  (require :makyo-fnl.init))

(fn plugins-already-installed? []
  (let [dir-count (length (vim.fn.globpath lazy-base-path "*" 0 1))]
    (> dir-count 4)))

(fn files-already-compiled? []
  (vim.uv.fs_stat (.. nvim-config-lua-path "/makyo-fnl")))

(fn clone-repo [repo-url ?branch dest]
  (-> (vim.system [
                   "git"
                   "clone"
                   "--filter=blob:none"
                   repo-url
                   (.. "--branch=" (or ?branch "master"))
                   dest
                   ])
      (: :wait)))

(fn embed-nfnl []
  (-> (vim.system [
                   "cp"
                   "-r"
                   (.. nfnl-path "/lua/nfnl")
                   nvim-config-lua-path
                   ])
      (: :wait))
  (-> (vim.system [
                   "mkdir"
                   "-p"
                   (.. nvim-fnl-path "/nfnl/macros")])
      (: :wait))
  (-> (vim.system [
                   "cp"
                   (.. nfnl-path "/fnl/macros/aniseed.fnlm")
                   (.. nvim-fnl-path "/nfnl/macros/")])
      (vim.system [
                   "cp"
                   (.. nfnl-path "/fnl/macros.fnlm")
                   (.. nvim-fnl-path "/nfnl")])
      (: :wait)))


;;; ---------------------------------------------
;;; BOOTSTRAP FUNCTIONS
;;; ---------------------------------------------


(fn bootstrap-lazy []
  "Bootstraps the lazy package manager and adds it to the runtime path."
  (when (not (vim.uv.fs_stat lazy-path))
    ;; Synchroneously clone the repo and place it in the right spot.
    (clone-repo "https://github.com/folke/lazy.nvim.git" "stable" lazy-path))
  (vim.opt.rtp:prepend lazy-path))

(fn bootstrap-nfnl []
  "Ensures that Nfnl is installed and embeds the Lua source files in
   the `/.lua` directory so that we don't depend on Lazy to make it
   available for us, which can be problematic due to the async nature
   of `lazy.setup`."
  (when (not (is-installed? :nfnl.core))
    (clone-repo "https://github.com/Olical/nfnl" "main" nfnl-path)
    (embed-nfnl))
  (vim.opt.rtp:prepend nfnl-path))

(fn bootstrap-nvim-lua []
  "Add nvim.lua to path as many of the modules in Makyo depend on
   it. Without this, setting up Lazy doesn't work as Lazy hasn't
   finished initializing this plugin."
  (when (not (is-installed? :nvim))
    (clone-repo "https://github.com/norcalli/nvim.lua" nvim-lua-path))
  (vim.opt.rtp:prepend nvim-lua-path))

(fn bootstrap []
  (bootstrap-lazy)
  (bootstrap-nfnl)
  (bootstrap-nvim-lua))


;;; ---------------------------------------------
;;; APP INITIALIZATION FUNCTIONS
;;; ---------------------------------------------


(fn start-app []
  "Fire the `LazyDone` event from Lazy to signal that we're
  ready to start with the rest of the initialization process."
  ;; NOTE: This has to be done here and not before we register all
  ;; specs. Otherwise, we experience breakage for certain plugins
  ;; which are not ready at the time that we try to configure them
  ;; separately.
  (vim.api.nvim_exec_autocmds [:User] {:group makyo-start-augroup :pattern "LazyDone"})
  (vim.print "[makyo] 👹 Plugins setup completed."))

(fn restore-plugins []
  "This is a 3-step process that initializes Makyo by making sure that
  all of its source files are transpiled to Lua ones and by ensuring
  that Lazy is setup correctly. The first two steps are meant to be run
  in headless mode."
  (let [lazy (require :lazy)
        {: compile-all-files} (require :nfnl.api)]
    (when (not (files-already-compiled?))
      ;; Compile all of the Fennel source files
      (compile-all-files nvim-config-path)
      (vim.print "[makyo] 👹 Compilation completed successfully.")
      (restart-neovim))

    ;; It is required to set up Lazy before being able to do anything
    ;; with it.
    (when (plugins-already-installed?)
      (lazy.setup "makyo-fnl.plugins.lazy.plugins" {:wait true}))

    ;; Restore all plugins from the lockfile
    (when (not (plugins-already-installed?))
      (lazy.setup "makyo-fnl.plugins.lazy.plugins" {:wait true})
      (lazy.restore {:wait true :show true}))))

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
    (bootstrap)
    (prepare-lazy-done-hook)
    (restore-plugins)
    (start-app)))

(init)
