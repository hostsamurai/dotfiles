(local wezterm (require :wezterm))

(local ui-config
  {
   :font (wezterm.font "FiraCode Nerd Font")
   :font_size 11.0
   :underline_position "200%"
   :color_scheme "Dracula (Official)"

   ;; configure tab bar appearance
   :window_frame {:font (wezterm.font "SF Compact Text")}

   ;; hide the tab bar if there is only 1 tab open
   :hide_tab_bar_if_only_one_tab true

   ;; never ask for confirmation when closing a window
   :window_close_confirmation "NeverPrompt"

   ;; disable titlebar and border
   :window_decorations "INTEGRATED_BUTTONS | RESIZE"

   :keys [
     ;; add additional pane manipulation keybinds
     {
      :key "v"
      :mods "CTRL|SHIFT"
      :action (wezterm.action.SplitHorizontal {:domain "CurrentPaneDomain"})
      }
     {
      :key "s"
      :mods "CTRL|SHIFT"
      :action (wezterm.action.SplitVertical  {:domain "CurrentPaneDomain"})
      }
     ]
   })

ui-config
