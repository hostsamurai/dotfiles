;; environment variables
(hl.env "XCURSOR_SIZE" "24")
(hl.env "HYPRCURSOR_SIZE" "24")

;; preferred applications 
(local terminal "wezterm")
(local menu "hyprlauncher")
(local browser "brave")

;; autostart 
(hl.on "hyprland.start" (lambda []
                          (hl.exec_cmd terminal)
                          (hl.exec_cmd "waybar & hyprpaper & brave")))

;; permissions 
(hl.config {:ecosystem {:enforce_permission true}})
(hl.permission "/usr/(bin|local/bin)/grim" "screencopy" "allow")
(hl.permission "/usr/(bin|libexec|lib64)/xdg-desktop-portal-hyprland" "screencopy" "allow")
(hl.permission "/usr/(bin|local/bin)/hyprpm" "plugin" "allow")

;;; look and feel  

;; Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
(hl.config {
    :general  {
        :gaps_in   5
        :gaps_out  20
        :border_size  2
        :col  {
            :active_border {:colors  ["rgba(33ccffee)" "rgba(00ff99ee)"] :angle  45}
            :inactive_border  "rgba(595959aa)"
        }
        ;; Set to true to enable resizing windows by clicking and dragging on borders and gaps
        :resize_on_border  false
        ;; Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        :allow_tearing  false
        :layout  "dwindle"
    }

    :decoration  {
        :rounding        10
        :rounding_power  2

        ;; Change transparency of focused and unfocused windows
        :active_opacity    1.0
        :inactive_opacity  1.0

        :shadow {
                 :enabled       true
                 :range         4
                 :render_power  3
                 :color         0xee1a1a1a
                 }
        :blur {
               :enabled    true
               :size       3
               :passes     1
               :vibrancy   0.1696
               }
        }

    :animations  {:enabled  true}
    })

;; Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
(hl.curve "easeOutQuint"   {:type  "bezier" :points  [[0.23 1]    [0.32 1]]})
(hl.curve "easeInOutCubic" {:type  "bezier" :points  [[0.65 0.05] [0.36 1]]})
(hl.curve "linear"         {:type  "bezier" :points  [[0 0]       [1 1]]})
(hl.curve "almostLinear"   {:type  "bezier" :points  [[0.5 0.5]   [0.75 1]]})
(hl.curve "quick"          {:type  "bezier" :points  [[0.15 0]    [0.1 1]]})

;; Default springs
(hl.curve "easy" {
                  :type "spring"  
                  :mass 1 
                  :stiffness 238.1191 
                  :dampening  24.21279333 
                  })

(hl.animation {:leaf  "global"        :enabled  true  :speed  10   :bezier  "default"})
(hl.animation {:leaf  "border"        :enabled  true  :speed  5.39 :bezier  "easeOutQuint"})
(hl.animation {:leaf  "windows"       :enabled  true  :speed  4.79 :spring  "easy"})
(hl.animation {:leaf  "windowsIn"     :enabled  true  :speed  4.1  :spring  "easy"         :style  "popin 87%"})
(hl.animation {:leaf  "windowsOut"    :enabled  true  :speed  1.49 :bezier  "linear"       :style  "popin 87%"})
(hl.animation {:leaf  "fadeIn"        :enabled  true  :speed  1.73 :bezier  "almostLinear"})
(hl.animation {:leaf  "fadeOut"       :enabled  true  :speed  1.46 :bezier  "almostLinear"})
(hl.animation {:leaf  "fade"          :enabled  true  :speed  3.03 :bezier  "quick"})
(hl.animation {:leaf  "layers"        :enabled  true  :speed  3.81 :bezier  "easeOutQuint"})
(hl.animation {:leaf  "layersIn"      :enabled  true  :speed  4    :bezier  "easeOutQuint" :style  "fade"})
(hl.animation {:leaf  "layersOut"     :enabled  true  :speed  1.5  :bezier  "linear"       :style  "fade"})
(hl.animation {:leaf  "fadeLayersIn"  :enabled  true  :speed  1.79 :bezier  "almostLinear"})
(hl.animation {:leaf  "fadeLayersOut" :enabled  true  :speed  1.39 :bezier  "almostLinear"})
(hl.animation {:leaf  "workspaces"    :enabled  true  :speed  1.94 :bezier  "almostLinear" :style  "fade"})
(hl.animation {:leaf  "workspacesIn"  :enabled  true  :speed  1.21 :bezier  "almostLinear" :style  "fade"})
(hl.animation {:leaf  "workspacesOut" :enabled  true  :speed  1.94 :bezier  "almostLinear" :style  "fade"})
(hl.animation {:leaf  "zoomFactor"    :enabled  true  :speed  7    :bezier  "quick"})

(hl.config {
            ;; -- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
            :dwindle {:preserve_split  true} 
            ;; See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
            :master {:new_status "master"}
            ;; See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
            :scrolling {:fullscreen_on_one_column true}
            })
 
;;; keybindings
;; See https://wiki.hypr.land/Configuring/Basics/Binds/ for more info
(local main-mod "SUPER")
(local mod "ALT")

(hl.bind (.. main-mod " + T") (hl.dsp.exec_cmd terminal))
(hl.bind (.. main-mod " + B") (hl.dsp.exec_cmd browser))
(hl.bind (.. main-mod " + space") (hl.dsp.exec_cmd menu))

;; Move focus with mod and arrow keys 
(hl.bind (.. mod " + left") (hl.dsp.focus {:direction "left"}))
(hl.bind (.. mod " + down") (hl.dsp.focus {:direction "down"}))
(hl.bind (.. mod " + up") (hl.dsp.focus {:direction "up"}))
(hl.bind (.. mod " + right") (hl.dsp.focus {:direction "right"}))
;; Same but with vim keys
(hl.bind (.. mod " + H") (hl.dsp.focus {:direction "left"}))
(hl.bind (.. mod " + J") (hl.dsp.focus {:direction "down"}))
(hl.bind (.. mod " + K") (hl.dsp.focus {:direction "up"}))
(hl.bind (.. mod " + L") (hl.dsp.focus {:direction "right"}))

;; switch workspace with main-mod and [0-9]
;; move an active window to a workspace by additionally pressing SHIFT
(for [i 1 10]
  (let [key (% i 10)]
    (hl.bind (.. main-mod " + " key) (hl.dsp.focus {:workspace i}))
    (hl.bind (.. main-mod " + SHIFT + " key) (hl.dsp.window.move {:workspace i}))))

;; scratchpad workspace
(hl.bind (.. main-mod " + S") (hl.dsp.workspace.toggle_special "magic"))
(hl.bind (.. main-mod " + SHIFT + S") (hl.dsp.window.move {:workspace "special:magic"}))

;; scroll through existing workspaces
(hl.bind (.. main-mod " + SHIFT + K") (hl.dsp.focus {:workspace "e+1"}))
(hl.bind (.. main-mod " + SHIFT + J") (hl.dsp.focus {:workspace "e-1"}))

;; move and resize windows using mod and the mouse buttons
;; TODO: figure out how to do this with keys like in gnome  
(hl.bind (.. main-mod " + mouse:272") (hl.dsp.window.drag) {:mouse true})
(hl.bind (.. main-mod " + mouse:273") (hl.dsp.window.resize) {:mouse true}) 

;; multimedia keys for volume
(hl.bind "XF86AudioRaiseVolume" (hl.dsp.exec_cmd "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+") {:locked true :repeating true})
(hl.bind "XF86AudioLowerVolume" (hl.dsp.exec_cmd "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-") {:locked true :repeating true})
(hl.bind "XF86AudioMute" (hl.dsp.exec_cmd "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") {:locked true :repeating true})
;; requires playerctl
(hl.bind "XF86AudioNext" (hl.dsp.exec_cmd "playerctl next") {:locked true})
(hl.bind "XF86AudioPrev" (hl.dsp.exec_cmd "playerctl previous") {:locked true})
(hl.bind "XF86AudioPlay" (hl.dsp.exec_cmd "playerctl play-pause") {:locked true})
(hl.bind "XF86AudioPause" (hl.dsp.exec_cmd "playerctl play-pause") {:locked true})
 
;;; windows and workspaces 

;; See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
;; and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

;; Ignore maximize requests from all apps except retroarch
(local suppressMaximizeRule 
       (hl.window_rule {
                        :name   "suppress-maximize-events"
                        :match  {:class  "negative:retroarch"}
                        :suppress_event  "maximize"
                        }))
 
(suppressMaximizeRule:set_enabled true)

;; fix some dragging issues with wayland
(hl.window_rule {
                 :name "fix-wayland-drags"
                 :match {
                         :class "^$"
                         :title "^$"
                         :wayland true 
                         :float true 
                         :fullscreen false 
                         :pin false
                         }
                 })
