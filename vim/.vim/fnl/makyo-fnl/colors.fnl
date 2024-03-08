(module makyo-fnl.colors
  {autoload {a aniseed.core
             nvim aniseed.nvim}})

(defn- tweeak-color-scheme []
  (nvim.command "syntax clear Pmenu")
  (nvim.command "hi! link Pmenu SneakScope")

  (nvim.command "hi! link NormalFloat SneakScope")

  (nvim.command "syntax clear StatusLineNC")
  (nvim.command "hi! link StatusLineNC airline_a_to_airline_b_inactive")

  (nvim.command "syntax clear VertSplit")
  (nvim.command "hi! VertSplit ctermbg=233 ctermfg=233 guibg=#1c1e26 guifg=#1c1e26")
  (nvim.command "hi! link WinSeparator Conceal"))

(defn init []
  (tweeak-color-scheme))
