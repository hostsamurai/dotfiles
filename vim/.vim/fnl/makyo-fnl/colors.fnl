(module makyo-fnl.colors
  {autoload {nvim aniseed.nvim}})

(defn tweak-color-scheme []
  (case nvim.g.colors_name
    "pinkmare" (do
                (nvim.command "AirlineTheme atomic")
                ;; Set the highlight groups for the indent lines
                (nvim.ex.highlight ["link" "IndentLine" "Conceal"]))
    "horizon" (do
                (nvim.command "syntax clear Pmenu")
                (nvim.command "hi! link Pmenu SneakScope")

                (nvim.command "hi! link NormalFloat SneakScope")

                (nvim.command "syntax clear StatusLineNC")
                (nvim.command "hi! link StatusLineNC airline_a_to_airline_b_inactive")

                (nvim.command "syntax clear VertSplit")
                (nvim.command "hi! VertSplit ctermbg=233 ctermfg=233 guibg=#1c1e26 guifg=#1c1e26")
                (nvim.command "hi! link WinSeparator Conceal"))))



(defn init []
  (tweak-color-scheme))
