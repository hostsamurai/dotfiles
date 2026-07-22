(import-macros {: module} :nfnl.macros.aniseed)

(module :plugins.colorschemes)

(local {: spec} (require :utils.spec))

[
 ;; LazyVim overrides 
 (spec "LazyVim/LazyVim" {:opts {:colorscheme "pinkmare"}})


 ;;; Additional plugins
 ;;; ----------------------------------------------
 
 (spec "matsuuu/pinkmare" {:lazy false :priority 2000})
 (spec "Mofiqul/dracula.nvim" {:lazy true})
 (spec "NTBBloodbath/doom-one.nvim" {:lazy true})
 (spec "ray-x/starry.nvim" {:lazy true
                            :priority 1000
                            :opts {:style {:name "dracula_blood"}
                                   :italics {:comments true :keywords true}}})

 ;; Toolkit for developing new color schemes
 (spec "lifepillar/vim-colortemplate" {:lazy true})
 ]
