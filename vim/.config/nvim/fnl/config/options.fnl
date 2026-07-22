(import-macros {
                : module
                : def
                : defn-
                }
               :nfnl.macros.aniseed)

(module :config.options)

(local {: trimr} (require :nfnl.string))
(local {: run-command} (require :utils.helpers))

(defn- set-global-options []
  (let [o vim.o 
        nvim-config-dir (vim.fn.stdpath "config")
        backup-dir (.. nvim-config-dir "/backups")]
    ;; Keep backups of files when necessary
    (set o.backup true)
    (set o.backupdir backup-dir)
    (set o.writebackup true)
    (set o.matchpairs "(:),{:},[:],<:>")
    (vim.opt.sessionoptions:append ["localoptions" "winpos"])))

(defn- set-ui-options []
  (let [o vim.o]
    (if (->> (run-command "uname")
             trimr
             (= "Linux"))
        (set o.guifont "FiraCode Nerd Font:h11")
        (set o.guifont "FiraCode Nerd Font:12.5"))
    (set o.linespace 4)))

(do 
  (set-global-options)
  (set-ui-options))
