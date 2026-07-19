(import-macros {: module
                : defn
                : def}
               :nfnl.macros.aniseed)

(module :utils.spec)

(local {: merge} (require :nfnl.core))

(defn spec [plugin-name spec-definitions]
  "Gets around Fennel's limitation of being unable to mix associative
  and sequential tables by using a sequential table with the plugin
  name as its first element, followed by the rest of the plugin
  definition. This is necessary for Lazy to detect spec definitions
  correctly."
  (merge [plugin-name] spec-definitions))
