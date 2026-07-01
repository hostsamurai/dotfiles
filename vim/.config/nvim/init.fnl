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

(local makyo-start-augroup (vim.api.nvim_create_augroup "makyo.startup" {:clear true}))


;;; ---------------------------------------------
;;; HELPER FUNCTIONS
;;; ---------------------------------------------


(fn lazy-exists? []
  (pcall require "lazy"))

(fn is-nfnl-installed? []
  (pcall require "nfnl.core"))

(fn running-headless? []
  (= (length (vim.api.nvim_list_uis)) 0))

(fn restart-neovim []
  (vim.api.nvim_cmd {:cmd "restart" :args ["+qall!"]} {}))

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
    (when (not (vim.loop.fs_stat lazy-path))
      ;; Synchroneously clone the repo and place it in the right spot.
      (-> (vim.system ["git"
                       "clone"
                       "--filter=blob:none"
                       "https://github.com/folke/lazy.nvim.git"
                       "--branch=stable"
                       lazy-path])
          (: :wait)))
    (vim.opt.rtp:prepend lazy-path)))

(fn restore-plugins []
  (let [lazy (require :lazy)]
    ;; NOTE: "Olical/nfnl" and "norcalli/nvim.lua" are essential to
    ;; our configuration and must be installed first.
    (vim.opt.rtp:prepend nfnl-path)
    ;; TODO: Remove nvim.lua entirely
    (vim.opt.rtp:prepend nvim-lua-path)

    (when (not (is-nfnl-installed?))
      ;; Install essential plugins
      (lazy.setup {:spec ["Olical/nfnl" "norcalli/nvim.lua"]})
      (vim.print "[makyo] 🔌 Successfully installed core plugins. Restarting to restore the rest...")
      (restart-neovim))

    (if (not (plugins-already-installed?))
      ;; Restore our plugins from the lock file.
      (do
        ;; Set up Lazy since lazy.restore complains about `headless`
        ;; being referenced incorrectly.
        (lazy.setup "makyo-fnl.plugins.lazy.plugins")
        (compile-all-files)
        (vim.print "[makyo] 🔌 Successfully installed all plugins.")
        (restart-neovim))
      ;; Required: set up Lazy.
      (lazy.setup "makyo-fnl.plugins.lazy.plugins"))

    (when (and (plugins-already-installed?) (not (running-headless?)))
      ;; Fire the `LazyDone` event from Lazy to signal that we're
      ;; ready to start with the rest of the initialization.
      (vim.api.nvim_exec_autocmds [:User] {:group makyo-start-augroup :pattern "LazyDone"}))

    (vim.print "[makyo] 🔌 Plugins have been restored.")))

(fn compile-all-files []
  "Compiles all Fennel files in our config directory. These amount to
   source files for Makyo for the most part. We only compile these
   files if the compiled `lua/makyo-fnl` directory doesn't exist."
  (let [{: compile-all-files} (require :nfnl.api)
        config-dir (vim.fn.stdpath "config")
        makyo-lua-dir (.. config-dir "/lua/makyo-fnl")]
    (when (not (vim.loop.fs_stat makyo-lua-dir))
      (vim.print "[makyo] Compiling config files")
      (compile-all-files config-dir)
      (vim.print "[makyo] Done. Restarting...")
      (restart-neovim))))

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


;; NOTE: Prerequisite for getting this all running is ensuring that
;; all of the plugins have been installed. Then, it becomes a matter of
;; initializing Lazy properly by importing all plugins during its
;; setup, then running :makyo-fnl.init.
;;
;; For this to work, nfnl has to be installed and :NfnlCompileAllFiles
;; in the nvim directory must be run after we re-install all of the
;; plugins.
;;
;; To recap:
;;
;; 1. If running headless, then just run bootstrap followed by
;;    lazy.setup and lazy.restore
;; 2. Otherwise, bootstrap, run lazy.setup. On LazyDone, run
;;    :makyo-fnl.init

(fn init []
  (if (running-headless?)
    (do
      (bootstrap-lazy)
      (restore-plugins))
    ;; Otherwise
    (do
      (bootstrap-lazy)
      (prepare-lazy-done-hook)
      (restore-plugins))))

(init)
