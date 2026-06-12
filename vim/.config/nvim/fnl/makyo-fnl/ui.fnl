;;;; Configures the UI

(import-macros {: module
                : def
                : defn-
                : defn}
               :nfnl.macros.aniseed)

(module makyo-fnl.ui)

(local {: println} (require :nfnl.core))
(local {: trimr} (require :nfnl.string))
(local {: run-command} (require :makyo-fnl.utils))

(defn- setup []
  "Assigns various GUI options"
  (let [o vim.o]
    (set o.ch 2) ;; Make command line two lines high
    (set o.termguicolors true) ;; Set 24-bit RGB color in TUI

    (set vim.g.neovide_cursor_animation_length 0.13)

    (if (->> (run-command "uname")
             trimr
             (= "Linux"))
      (set o.guifont "FiraCode Nerd Font,Noto Color Emoji:h11")
      (set o.guifont "FiraCode Nerd Font:h12.5"))

    (set o.linespace 4)))

(defn init []
  "Initialize GUI settings"
  (do
    (println "[makyo] 📺 Applying UI settings...")
    (setup)
    (println "[makyo] 📺 Done.")))
