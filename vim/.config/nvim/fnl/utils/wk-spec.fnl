(import-macros {
                : module
                : defn
                : def
                }
                :nfnl.macros.aniseed)

(module :utils.wk-spec)

(local {: merge} (require :nfnl.core))

(defn wk-spec [& args]
  "Gets around Fennel's limitation of being unable to mix associative
  and sequential tables by using a sequential table with the lhs and
  rhs as its first elements, followed by the keymap options. Without 
  this, the keymap descriptions do not show up at all in the 
  which-key menu popup."
  (match args 
    [lhs rhs opts] (merge [lhs rhs] opts)
    [lhs rhs] (merge [lhs] rhs)))
