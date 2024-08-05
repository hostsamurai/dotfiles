;;; An assortment of helper functions
(module makyo-fnl.utils
  {autoload {nvim aniseed.nvim}})

(defn is-darwin? []
  (-> (nvim.fn.system "uname")
      (nvim.fn.trim)
      (string.lower)
      (= "darwin")))

(defn is-linux? []
  (-> (nvim.fn.system "uname")
      (nvim.fn.trim)
      (string.lower)
      (= "linux")))
