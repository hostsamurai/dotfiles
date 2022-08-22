(module makyo-fnl.providers
  {require {a aniseed.core
            nvim aniseed.nvim}})

(defn init []
  "Set up providers to support remote plugins."
  (do
    (if (-> (nvim.fn.system "uname")
            (nvim.fn.trim)
            (= "Linux"))
      (set nvim.g.python3_host_prog "/usr/bin/python")
      (set nvim.g.python3_host_prog "/usr/local/bin/python"))))
