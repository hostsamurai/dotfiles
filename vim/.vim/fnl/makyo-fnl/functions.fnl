;;;; General functions used in user commands
(module makyo-fnl.functions
  {require {a aniseed.core
            nvim aniseed.nvim}})

(defn- create-scratch-buffer []
  "Opens a scratch buffer in a new tab"
  (nvim.command "tabnew scratch | setlocal buftype=nofile bufhidden=hide noswapfile"))

(defn- kill-floating-windows []
  "Kills all orphaned floating windows. Useful for cases when the
  focus is lost and we can no longer navigate over to the floating
  window."
  ;; TODO: This can be simplified by using the functions provided in
  ;; aniseed.core.
  (icollect [_ win (ipairs (nvim.list_wins))]
    (let [{: relative} (nvim.win_get_config win)]
      (when (~= relative "")
        (nvim.win_close win false)
        (a.println "Closing window " win)))))

(defn init []
  (do
    (a.println "[makyo] 🚥 Initializing helper functions and commands...")
    (vimp.map_command "Scratch" create-scratch-buffer)
    (vimp.map_command "KillAllFloatingWindows" kill-floating-windows)
    (a.println "[makyo] 🚥 Done.")))
