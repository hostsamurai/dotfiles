(import-macros {
                : module
                : def
                : defn
                }
               :nfnl.macros.aniseed)

(module :makyo-fnl.colors)

(defn tweak-color-scheme []
  (case vim.g.colors_name
    "pinkmare" (do
                (vim.api.nvim_exec2 "AirlineTheme atomic" {:output true})
                ;; Set the highlight groups for the indent lines
                (vim.api.nvim_exec2 "hi! link IndentLine Conceal" {:output true}))
    "horizon" (do
                (vim.api.nvim_exec2 "syntax clear Pmenu" {:output true})
                (vim.api.nvim_exec2 "hi! link Pmenu SneakScope" {:output true})

                (vim.api.nvim_exec2 "hi! link NormalFloat SneakScope" {:output true})

                (vim.api.nvim_exec2 "syntax clear StatusLineNC" {:output true})
                (vim.api.nvim_exec2 "hi! link StatusLineNC airline_a_to_airline_b_inactive" {:output true})

                (vim.api.nvim_exec2 "syntax clear VertSplit" {:output true})
                (vim.api.nvim_exec2 "hi! VertSplit ctermbg=233 ctermfg=233 guibg=#1c1e26 guifg=#1c1e26" {:output true})
                (vim.api.nvim_exec2 "hi! link WinSeparator Conceal" {:output true}))))

(defn init []
  (tweak-color-scheme))
