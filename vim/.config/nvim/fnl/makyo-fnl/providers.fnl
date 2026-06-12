(import-macros {: module
                : defn
                : def}
               :nfnl.macros.aniseed)

(module makyo-fnl.providers)

(local {: get} (require :nfnl.core))
(local {: trimr} (require :nfnl.string))

(defn init []
  "Set up providers to support remote plugins."
  (do
    (if (-> (vim.system ["uname"] {:text true})
            (: :wait)
            (get :stdout)
            (trimr)
            (= "Linux"))
      (set vim.g.python3_host_prog "/usr/bin/python")
      (set vim.g.python3_host_prog "/opt/homebrew/bin/python3"))))
