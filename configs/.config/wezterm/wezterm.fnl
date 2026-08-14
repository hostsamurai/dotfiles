(local wezterm (require :wezterm))
(local gpus (wezterm.gui.enumerate_gpus))

{
 ;; BEGIN_WEZTERM_FONTS
 ;; Mimic Kitty's look for this font. Relevant documentation can be 
 ;; found here: 
 ;;
 ;; https://wezterm.org/config/lua/wezterm/font.html 
 ;; https://wezterm.org/config/lua/config/font_rules.html?h=font_rules
 :font (wezterm.font "Ioskeley Mono Term")
 :font_rules [
              ;; Normal 
              {
               :font (wezterm.font {
                                    :family "Ioskeley Mono Term" 
                                    :stretch "SemiCondensed"
                                    :weight "DemiBold"
                                    }) 
               :intensity "Normal" 
               :italic false 
               }

              ;; Bold 
              {
               :font (wezterm.font {
                                    :family "Ioskeley Mono Term" 
                                    :stretch "SemiCondensed"
                                    :weight "ExtraBlack"
                                    }) 
               :intensity "Bold" 
               :italic false
               }

              ;; Italic
              {
               :font (wezterm.font {
                                    :family "Ioskeley Mono Term" 
                                    :stretch "SemiCondensed"
                                    :weight "DemiBold" 
                                    :style "Italic"
                                    }) 
               :intensity "Normal" 
               :italic true
               }

              ;; Bold Italic
              {
               :font (wezterm.font {
                                    :family "Ioskeley Mono Term" 
                                    :stretch "SemiCondensed"
                                    :weight "ExtraBlack" 
                                    :style "Italic"
                                    }) 
               :intensity "Bold" 
               :italic true
               }

              ;; Repeat the above for half intensity
              ;; DemiBold 
              {
               :font (wezterm.font {
                                    :family "Ioskeley Mono Term" 
                                    :stretch "SemiCondensed"
                                    :weight "ExtraBlack"
                                    }) 
               :intensity "Half" 
               :italic false
               }

              ;; DemiBold Italic
              {
               :font (wezterm.font {
                                    :family "Ioskeley Mono Term" 
                                    :stretch "SemiCondensed"
                                    :weight "ExtraBlack" 
                                    :style "Italic"
                                    }) 
               :intensity "Half" 
               :italic true
               }
              ]
 :freetype_load_flags "NO_HINTING|MONOCHROME|NO_AUTOHINT|NO_BITMAP"
 :freetype_load_target nil
 :freetype_render_target nil
 :freetype_interpreter_version 40
 :foreground_text_hsb {:hue 1.0 :saturation 1.25 :brightness 1.5}
 :font_shaper "Harfbuzz"
 :cell_width 0.8
 :font_size 8.0125
 :dpi 138.0
 ;; END_WEZTERM_FONTS
 
 :color_scheme "Heetch Dark (base16)"

 :window_decorations "RESIZE"
 :enable_tab_bar false
 :window_padding {:left 0 :right 0 :top 0 :bottom 0}

 :front_end "WebGpu"
 :webgpu_preferred_adapter (. gpus 1)
 :webgpu_power_preference "HighPerformance"
}
