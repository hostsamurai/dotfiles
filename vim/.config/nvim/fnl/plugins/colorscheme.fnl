(import-macros {: module} :nfnl.macros.aniseed)

(module :plugins.colorschemes)

(local {: spec} (require :utils.spec))
(local highlights (require :config.highlights))

[
 ;; LazyVim overrides 
 (spec "LazyVim/LazyVim" {:opts {:colorscheme "pinkmare"}})


 ;;; Additional plugins
 ;;; ----------------------------------------------
 
 (spec "matsuuu/pinkmare" 
       { 
        :lazy false 
        :priority 2000
        :config #(highlights.init)
        })
 (spec "rose-pine/neovim" {:lazy true :name "rose-pine"}) ;; 2nd favorite theme
 (spec "Mofiqul/dracula.nvim" {:lazy true})
 (spec "NTBBloodbath/doom-one.nvim" {:lazy true})
 (spec "ray-x/starry.nvim" {:lazy true
                            :priority 1000
                            :opts {:style {:name "dracula_blood"}
                                   :italics {:comments true :keywords true}}})

 ;; Toolkit for developing new color schemes
 (spec "lifepillar/vim-colortemplate" {:lazy true})
 ]
