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

(defn safe-require [mod]
  "Calls `require` within a protected call to prevent any failures
  when loading Lua modules that cannot be found. This is particularly
  useful for some modules, like `which-key`, which fail to be
  required via the normal means."
  (let [(ok? req-mod) (pcall require mod)]
    (if ok? req-mod nil)))
