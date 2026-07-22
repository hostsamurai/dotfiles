;;; An assortment of helper functions
(import-macros {
                : module
                : def
                : defn
                : defn-
                }
                :nfnl.macros.aniseed)

(module :utils.helpers)

(local {: nil?
        : empty?
        : contains?
        : get
        } (require :nfnl.core))
(local {: trim} (require :nfnl.string))

(defn run-command [cmd]
  (-> (vim.system [cmd] {:text true})
      (: :wait)
      (get :stdout)))

(defn is-darwin? []
  (-> (run-command "uname")
      (trim)
      (string.lower)
      (= "darwin")))

(defn is-linux? []
  (-> (run-command "uname")
      (trim)
      (string.lower)
      (= "linux")))

(defn is-running-headless? []
  "Is Neovim running in headless mode?"
  (empty? (vim.api.nvim_list_uis)))

(defn is-claude-installed? []
  (-> (run-command "which claude")
      (trim)
      (string.match "/claude$")
      (nil?)
      (not)))

(defn is-markdown-buffer? []
  (= "markdown" vim.bo.filetype))

(defn is-lisp-buffer? []
  (contains? [
              "lisp"
              "cl"
              "clojure"
              "clojurescript"
              "fennel"
              "chicken"
              "racket"
              "scheme"
              "julia"
              ] 
             vim.bo.filetype))

(defn safe-require [mod]
  "Calls `require` within a protected call to prevent any failures
  when loading Lua modules that cannot be found. This is particularly
  useful for some modules, like `which-key`, which fail to be
  required via the normal means."
  (let [(ok? req-mod) (pcall require mod)]
    (if ok? req-mod nil)))

