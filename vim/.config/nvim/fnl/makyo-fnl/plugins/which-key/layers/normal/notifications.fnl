(import-macros {
                : module
                : defn-
                : def
                }
                :nfnl.macros.aniseed)

(module :makyo-fnl.plugins.which-key.layers.normal.notifications)

(defn- get-snacks []
  (let [Snacks (require :snacks)]
    Snacks))

(def notifications-layer
  {
   :n {
       :name "+notifications"
       :h [#(let [Snacks (get-snacks)]
              (Snacks.notifier.show_history)) "show notification history"]
      }
   })
