(module makyo-fnl.plugins.lazy.plugins.general-purpose
  {require {a aniseed.core
            {: spec} makyo-fnl.plugins.lazy.spec}
   autoload {{: normal-mode-layers
              : visual-mode-layers} makyo-fnl.plugins.which-key}})

(def general-purpose-plugins
  [
   (spec "folke/which-key.nvim"
         {:event "VeryLazy"
          :opts {
                 :spec (a.merge normal-mode-layers visual-mode-layers)
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

   "skywind3000/asynctasks.vim"
   ])
