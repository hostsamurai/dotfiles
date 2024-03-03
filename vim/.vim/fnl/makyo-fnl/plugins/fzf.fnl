(module makyo-fnl.plugins.fzf
  {require {a aniseed.core
            nvim aniseed.nvim}})

(set nvim.env.FZF_DEFAULT_OPTS "--layout=reverse --info=inline")
(set nvim.env.FZF_DEFAULT_COMMAND "rg --hidden --iglob '!.git' --files ")

;; Make fzf delegate its search responsibility to ripgrep. This turns fzf
;; into a simple selector interface.
(defn- create-dynamic-ripgrep [query fullscreen]
  (let [q (or query "")
        f (or fullscreen false)
        command-fmt "rg --column --line-number --no-heading --color=always --smart-case --hidden --iglob '!.git' -- %s || true"
        inital-cmd (nvim.fn.printf command-fmt (nvim.fn.shellescape q))
        reload-cmd (nvim.fn.printf command-fmt "{q}")
        spec {:options ["--phony" "--multi" "--query" q "--bind" (.. "change:reload:" reload-cmd)]}
        fzf-grep-fn (a.get-in vim [:fn "fzf#vim#grep"])
        fzf-with-preview (a.get-in vim [:fn "fzf#vim#with_preview"])]
    (fzf-grep-fn inital-cmd 1 (fzf-with-preview spec) f)))

(defn- build-quickfix-list [lines]
  (let [entries (a.map (fn [l] {:filename l}) lines)]
    (do
      (nvim.fn.setqflist entries)
      (nvim.fn.copen)
      (nvim.fn.nvim_feedkeys "cc" "n" true))))

(defn- customize-fzf-variables []
  (do
    (set nvim.g.fzf_action {"ctrl-t" "tab vsplit" "ctrl-s" "split" "ctrl-v" "vsplit"})
    (set nvim.g.fzf_history_dir "~/.local/share/fzf-history")
    ;; [Buffers] Jump to existing window if possible
    (set nvim.g.fzf_buffers_jump 1)
    ;; [Tags] Command to generate tags files
    (set nvim.g.fzf_tags_command "ctags -R")))

(defn- create-custom-fzf-commands []
  ;; Set up a command for using the advanced rg integration fn above.
  (do
    (vimp.map_command "FzfRRG" create-dynamic-ripgrep)
    ;; Override the [Files] command so that it uses the previewer
    (nvim.command "command! -bang  -nargs=? -complete=dir FzfFiles call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)")))

(defn init []
  (do
    (a.println "[makyo][plugins][fzf] Setting up fzf...")
    (customize-fzf-variables)
    (create-custom-fzf-commands)
    (a.println "[makyo][plugins][fzf] Done.")))
