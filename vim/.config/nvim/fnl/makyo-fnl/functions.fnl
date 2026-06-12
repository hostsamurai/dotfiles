;;;; General functions used in user commands
(import-macros {
                : module
                : def
                : defn-
                : defn
                }
                :nfnl.macros.aniseed)

(module makyo-fnl.functions)

(local {: println} (require :nfnl.core))
(local nvim (require :nvim))

(defn- create-scratch-buffer []
  "Opens a scratch buffer in a new tab"
  (nvim.command "tabnew scratch | setlocal buftype=nofile bufhidden=hide noswapfile"))

(defn- kill-floating-windows []
  "Kills all orphaned floating windows. Useful for cases when the
  focus is lost and we can no longer navigate over to the floating
  window."
  ;; TODO: This can be simplified by using the functions provided in
  ;;
  (icollect [_ win (ipairs (nvim.list_wins))]
    (let [{: relative} (nvim.win_get_config win)]
      (when (~= relative "")
        (nvim.win_close win false)
        (println "Closing window " win)))))

(defn init []
  (do
    (println "[makyo] 🚥 Initializing helper functions and commands...")
    (vimp.map_command "Scratch" create-scratch-buffer)
    (vimp.map_command "KillAllFloatingWindows" kill-floating-windows)
    (println "[makyo] 🚥 Done.")))
