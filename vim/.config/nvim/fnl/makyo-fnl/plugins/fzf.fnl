(import-macros {
                : module
                : def
                : defn-
                : defn
                }
                :nfnl.macros.aniseed)

;; TODO: Migrate to fzf-lua
(module makyo-fnl.plugins.fzf)

(local {: println
        : map
        : get-in
        } (require :nfnl.core))
(local {: join} (require :nfnl.string))

(defn- override-capital-rg-command [{: args}]
  (let [fzf-grep-fn (get-in vim [:fn "fzf#vim#grep"])
        fzf-with-preview-fn (get-in vim [:fn "fzf#vim#with_preview"])
        spec {:options ["--phony" "--multi" "--query" args]}
        rg-cmd (join " " [
                          "rg"
                          "--hidden"
                          "--column"
                          "--line-number"
                          "--no-heading"
                          "--color=always"
                          "--smart-case"
                          "--"
                          args
                          ])]
    (fzf-grep-fn rg-cmd (fzf-with-preview-fn spec) true)))

(defn- create-custom-fzf-commands []
  (do
    ;; Set up a command for using the advanced rg integration fn above.
    (vim.api.nvim_create_user_command "FzfRG"
                                      override-capital-rg-command
                                      {:bang true :nargs "*" :force true})))

(defn init []
  (do
    (println "[makyo][plugins][fzf] Setting up fzf...")
    (create-custom-fzf-commands)
    (println "[makyo][plugins][fzf] Done.")))
