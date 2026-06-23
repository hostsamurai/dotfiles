(import-macros {: module
                : def}
               :nfnl.macros.aniseed)

(module makyo-fnl.plugins.lazy.plugins.general)

(local {: merge} (require :nfnl.core))
(local {: spec} (require :makyo-fnl.plugins.lazy.spec))
(local {: normal-mode-layers
        : visual-mode-layers} (require :makyo-fnl.plugins.which-key))

(def general-purpose-plugins
  [
   (spec "folke/which-key.nvim"
         {:event "VeryLazy"
          :opts {
                 :spec (merge normal-mode-layers visual-mode-layers)
                 :triggers {1 "<leader>" :mode ["n" "v"]}
                 :plugins {:presets {
                                     :operators false
                                     :motions false
                                     :nav false
                                     :z false
                                     :g false
                                     }}
                 }
          :dependencies "nvim-tree/nvim-web-devicons"
          })

   (spec "folke/snacks.nvim"
         {:priority 1000
          :lazy false
          :opts {
                  :input {:enabled true}
                  :notifier {:enabled true :timeout 3000}
                  :image {:enabled true}
                  :scratch {:enabled true :win {:width 200 :height 60}}
                 }})
   ])

;; Export them
general-purpose-plugins
