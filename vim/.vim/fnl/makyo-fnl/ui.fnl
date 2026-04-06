;;;; Configures the UI
(module makyo-fnl.ui
  {require {a aniseed.core
            nvim aniseed.nvim
            {: trimr} aniseed.string}})

(defn- setup []
  "Assigns various GUI options"
  (let [o nvim.o]
    (set o.ch 2) ;; Make command line two lines high
    (set o.termguicolors true) ;; Set 24-bit RGB color in TUI

    (set nvim.g.neovide_cursor_animation_length 0.13)

    (if (->> (nvim.fn.system  "uname")
             trimr
             (= "Linux"))
      (set o.guifont "FiraCode Nerd Font,Noto Color Emoji:h11")
      (set o.guifont "FiraCode Nerd Font:h13"))))

(defn init []
  "Initialize GUI settings"
  (do
    (a.println "[makyo] 📺 Applying UI settings...")
    (setup)
    (a.println "[makyo] 📺 Done.")))
