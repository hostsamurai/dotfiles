;;;; Which-key configuration
(import-macros {
                : module
                : defn-
                : defn
                : def
                }
                :nfnl.macros.aniseed)

(module makyo-fnl.plugins.which-key)

(local {: println
        : reduce
        : concat
        : kv-pairs
        : merge
        : merge!
        : table?
        : first
        : second
        : nil?} (require :nfnl.core))
(local utils (require :makyo-fnl.utils))
(local layers (require :makyo-fnl.plugins.which-key.layers))

(defn- wk-spec [{: map : cmd : opts}]
  "Creates an entry that conforms to the v3 which-key spec. These
  can take on two different forms:

  {\"<map>\" opts}
  {\"<map>\" command opts}"
  (if (nil? cmd)
    (merge [map] opts)
    (merge [map cmd] opts)))

(defn to-new-spec [old-spec ?prefix]
  "Takes a group of mappings that does not conform to v3 of the
  folke/which-key.nvim spec and makes them conform to the v3 spec."
  (reduce (fn [last vals]
              (let [[k v] vals
                    new-prefix (.. (or ?prefix "") k)]
                (if (and (table? v) (?. v :name))
                  (concat last [(wk-spec {:map (.. "<leader>" new-prefix) :opts {:group (?. v :name)}})] (to-new-spec v new-prefix))
                  (not (= k "name"))
                  (concat last [(wk-spec {:map (.. "<leader>" new-prefix) :cmd (first v) :opts {:desc (second v)}})])
                  last)))
            []
            (kv-pairs old-spec)))

(def normal-mode-layers
  (to-new-spec layers.normal-mode-layers))

(def visual-mode-layers
  (merge! {:mode "v"} (to-new-spec layers.visual-mode-layers)))

(def terminal-mode-layers
  (merge! {:mode "t"} (to-new-spec layers.terminal-mode-layers)))

(defn setup-mappings []
  (let [wk (utils.safe-require :which-key)
        all-layers [
                    normal-mode-layers
                    visual-mode-layers
                    ]]
    (wk.add all-layers)))
