(import-macros {: module
                : def-
                : def
                : defn-
                : defn
                }
                :nfnl.macros.aniseed)

(module makyo-fnl.plugins.alpha)

(local {: map
        : map-indexed
        : assoc
        : keys
        : get
        : pr-str} (require :nfnl.core))

;; Logo snatched from here: https://github.com/typecraft-dev/dotfiles/blob/master/nvim/.config/nvim/lua/plugins/snacks.lua
(def- header "
                                               
       ████ ██████           █████      ██
      ███████████             █████ 
      █████████ ███████████████████ ███   ███████████
     █████████  ███    █████████████ █████ ██████████████
    █████████ ██████████ █████████ █████ █████ ████ █████
  ███████████ ███    ███ █████████ █████ █████ ████ █████
 ██████  █████████████████████ ████ █████ █████ ████ ██████

")

(defn- get-header-section []
  {:type "text" :val header :opts {:position "center" :hl "Type"}})

(def- default-buttons-group-defaults
  [
   ["e" "  New file" "<cmd>ene <CR>"]
   ["f" "󰈞  Find file" "<cmd>FzfFiles<cr>"]
   ["r" "  MRU" "<cmd>FzfHistory<cr>"]
   ["g" "󰈬  Find word" "<cmd>FzfRg<cr>"]
   ["b" "  Jump to bookmarks" "<cmd>FzfMarks<cr>"]
   ["s" "  Load a session" #(vim.g.makyo_sessions.select)]
   ["u" "  Update plugins" "<cmd>Lazy sync<CR>"]
   ["q" "󰅚  Quit" "<cmd>qa<CR>"]
   ])

(defn- create-default-buttons-group [dashboard]
  (let [buttons-group {:opts {:spacing 1} :type "group"}
        buttons (map (fn [[shortcut text command]]
                         (dashboard.button shortcut text command)) default-buttons-group-defaults)]
    (assoc buttons-group :val buttons)))

(defn- create-sessions-group [dashboard]
  "Lists all sessions and assigns numbers as shortcut keys for loading
   them quickly."
  (let [sessions-group {:opts {:spacing 1} :type "group"}
        sessions (map-indexed
                   (fn [[k v]]
                     (dashboard.button (pr-str k) v (partial vim.g.makyo_sessions.read v)))
                   (keys (get vim.g.makyo_sessions :detected)))]
    (assoc sessions-group :val sessions)))

(defn- get-default-footer []
  {:type "text" :val "" :opts {:position "center" :hl "Number"}})

(defn create-config [dashboard]
  "Creates a custom dashboard similar to what alpha already provides,
   but with an added section for quickly loading sessions."
  {:layout
   [
    {:type "padding" :val 2}
    (get-header-section)
    {:type "padding" :val 2}
    (create-default-buttons-group dashboard)
    {:type "padding" :val 2}
    (create-sessions-group dashboard)
    (get-default-footer)
    ]
   :opts {:margin 5}})
