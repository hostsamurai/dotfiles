(module makyo-fnl.plugins.alpha
  {autoload {a aniseed.core
             nvim aniseed.nvim}})

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
   ["s" "  Load a session" #(nvim.g.makyo_sessions.select)]
   ["u" "  Update plugins" "<cmd>Lazy sync<CR>"]
   ["q" "󰅚  Quit" "<cmd>qa<CR>"]
   ])

(defn- create-default-buttons-group [dashboard]
  (let [buttons-group {:opts {:spacing 1} :type "group"}
        buttons (a.map (fn [[shortcut text command]]
                         (dashboard.button shortcut text command)) default-buttons-group-defaults)]
    (a.assoc buttons-group :val buttons)))

(defn- create-sessions-group [dashboard]
  "Lists all sessions and assigns numbers as shortcut keys for loading
   them quickly."
  (let [sessions-group {:opts {:spacing 1} :type "group"}
        sessions (a.map-indexed
                   (fn [[k v]]
                     (dashboard.button (a.pr-str k) v (partial nvim.g.makyo_sessions.read v)))
                   (a.keys (a.get nvim.g.makyo_sessions :detected)))]
    (a.assoc sessions-group :val sessions)))

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
