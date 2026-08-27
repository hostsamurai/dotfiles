(import-macros {: module} :nfnl.macros.aniseed)

(module :plugins.ai)

(local {: spec} (require :utils.spec))
(local {: wk-spec} (require :utils.wk-spec))

[

 ;; LazyVim overrides 


 ;;; Additional plugins
 ;;; ----------------------------------------------
 
 ;; Bridge pi's in-prompt completion into the Neovim instance pi launches
 (spec "dabstractor/pi-nvim-bridge"
       {:lazy false :config #(let [pi-bridge (require :pi-bridge)]
                               (pi-bridge.setup))})

 (spec "olimorris/codecompanion.nvim" 
       {
        :dependencies [
                       "nvim-lua/plenary.nvim" 
                       "nvim-treesitter/nvim-treesitter" 
                       "ravitemer/mcphub.nvim"
                       ]
        :version "^19.0.0"
        :opts {}
        :config (fn []
                  (let [codecompanion (require :codecompanion)]
                    (codecompanion.setup {:extensions 
                                           {:mcphub {:callback "mcphub.extensions.codecompanion" 
                                                     :opts {
                                                            :make_vars true 
                                                            :make_slash_commands true 
                                                            :show_result_in_chat true
                                                            }}}})))
        })
 ]
