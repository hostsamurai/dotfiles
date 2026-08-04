(import-macros {: module} :nfnl.macros.aniseed)

(module :plugins.ui)

(local {: spec} (require :utils.spec))
(local {: wk-spec} (require :utils.wk-spec))

[
 ;; Lazy defaults overrides
 (spec "folke/snacks.nvim" 
       {:opts {
               :dim {:enabled true} 
               :input {:enabled true}
               }
        :init (fn []
                (let [snacks (require :snacks)] 
                  (vim.api.nvim_create_autocmd "User" {:pattern "VeryLazy" 
                                                       ;; Turn on dimming without manually toggling it on
                                                       :callback #(snacks.dim.enable)})))})

 (spec "folke/noice.nvim" {:config #(let [noice (require :noice)]
                                      ;; Display cmdline in the middle of the screen
                                      (noice.setup {:views {:cmdline_popup {:pos {:row "50%" :col "50%"}}}}))})

 (spec "akinsho/bufferline.nvim" 
       {:config (fn []
                  (let [bufferline (require :bufferline)]
                    (bufferline.setup {:options {
                                                 :mode "tabs" 
                                                 :style_preset "default" 
                                                 :themable true 
                                                 :separator_style "thick" 
                                                 }})))
        :keys [(wk-spec "<leader><Tab>p" "<cmd>BufferLinePick<cr>" {:desc "Pick Tab"})]})

 (spec "nvim-lualine/lualine.nvim" 
       {:opts (fn [_ opts]
                ;; Remove the clock
                (table.remove opts.sections.lualine_z)
                (set opts.extensions (vim.list_extend opts.extensions [
                                                                       "symbols-outline" 
                                                                       "mason" 
                                                                       "mundo" 
                                                                       "toggleterm"
                                                                       ])))})

 ;;; Additional plugins
 ;;; ----------------------------------------------
 
 ;; buffer explorer 
 (spec "xiaoqixian/buffer-explorer.nvim" 
       {:lazy false :dependencies ["nvim-lua/plenary.nvim" "nvim-tree/nvim-web-devicons"]})

 ;; Fade inactive buffers
 "TaDaa/vimade"

 ;; Animations for yank and paste
 (spec "rachartier/tiny-glimmer.nvim" 
       {
        :event "VeryLazy"
        :priority 10 ;; low priority to catch other plugins' keybindings 
        :config #(let [tiny-glimmer (require :tiny-glimmer)]
                   (tiny-glimmer.setup))
        })

 ;; window picker 
 (spec "gbrlsnchs/winpick.nvim"
       {:keys [(wk-spec "<leader>ww" 
                        #(let [winpick (require :winpick)]
                           (winpick.select {:prompt nil})) 
                        {:desc "Jump to Window"})]})

 ;; color picker
 (spec "eero-lehtinen/oklch-color-picker.nvim"
       {
        :event "VeryLazy"
        :version "*"
        :opts {:highlight {:style "virtual_left"}}
        ;; Expose the picker globally so we don't have to `require` it all
        ;; of the time.
        :init #(let [colorpicker (require :oklch-color-picker)]
                  (set vim.g.colorpicker colorpicker))
        })
 ]
