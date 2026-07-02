(import-macros {
                : module
                : def
                : defn
                }
               :nfnl.macros.aniseed)

(module :makyo-fnl.plugins.luasnip)

(defn setup [luasnip loaders]
  (let [{: snipmate} loaders]
    (vim.keymap.set ["i"] "<C-K>" #(ls.expand) {:silent true})
    (vim.keymap.set ["i" "s"] "<C-L>" #(ls.jump 1) {:silent true})
    (vim.keymap.set ["i" "s"] "<C-J>" #(ls.jump -1) {:silent true})
    (vim.keymap.set ["i" "s"] "<C-E>" #(when (ls.choice_active)
                                                          (ls.change_choice 1)) {:silent true})
    ;; Configure snippets
    (snipmate.lazy_load {:paths "~/.local/share/nvim/custom_snippets"})))
