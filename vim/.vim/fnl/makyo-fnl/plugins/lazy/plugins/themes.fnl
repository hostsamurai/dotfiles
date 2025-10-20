(module makyo-fnl.plugins.lazy.plugins.themes
  {require {{: spec} makyo-fnl.plugins.lazy.spec}})

(def themes
  [
   (spec "ntk148v/vim-horizon" {:lazy true
                                :config #(vim.cmd "colorscheme horizon")})
   (spec "tomasr/molokai" {:lazy true})
   (spec "vim-scripts/fruity.vim" {:lazy true})
   (spec "altercation/vim-colors-solarized" {:lazy true})
   (spec "atelierbram/Base2Tone-vim" {:lazy true})
   (spec "yuttie/hydrangea-vim" {:lazy true})
   (spec "cseelus/vim-colors-lucid" {:lazy true})
   (spec "cseelus/vim-colors-tone" {:lazy true})
   (spec "flrnprz/candid.vim" {:lazy true})
   (spec "colepeters/spacemacs-theme.vim" {:lazy true})
   (spec "phanviet/vim-monokai-pro" {:lazy true})
   (spec "cideM/yui" {:lazy true})
   (spec "bruth/vim-newsprint-theme" {:lazy true})
   (spec "arzg/vim-colors-xcode" {:lazy true})
   (spec "vim-scripts/AfterColors.vim" {:lazy true})
  ;; treesitter-compatible color schemes
   (spec "nvimdev/zephyr-nvim" {:lazy true})
   (spec "Iron-E/nvim-highlite" {:lazy true})
   (spec "rockerBOO/boo-colorscheme-nvim" {:lazy true
                                           :priority 1000
                                           :opts {:italic true :theme "crimson_moonlight"}
                                           :main "boo-colorscheme"})
   (spec "nvimdev/zephyr-nvim" {:lazy true})
   (spec "savq/melange-nvim" {:lazy true})
   (spec "matsuuu/pinkmare" {:lazy true})
   (spec "Mofiqul/dracula.nvim" {:lazy true})
   (spec "NTBBloodbath/doom-one.nvim" {:lazy true})
   (spec "sainnhe/sonokai" {:lazy true})
   (spec "comfysage/evergarden" {:lazy true
                                 :priority 1000
                                 :opts {:contrast_dark "medium"}})
   (spec "ray-x/starry.nvim" {:lazy false
                              :priority 1000
                              :opts {:style {:name "dracula_blood"}
                                     :italics {:comments true :keywords true}}})
   (spec "AstroNvim/astrotheme" {:lazy true
                                 :priority 1000
                                 :opts {:palette "astromars"
                                        :style {:simple_syntax_colors false}}})

   (spec "rakr/vim-two-firewatch" {:lazy true
                                   :init #(set vim.g.two_firewatch_italics true)})

   (spec "ryanoasis/vim-devicons" {:init #(set vim.g.airline_powerline_fonts 1)})

   ;; Toolkit for developing new color schemes
   (spec "lifepillar/vim-colortemplate" {:lazy true})
  ])
