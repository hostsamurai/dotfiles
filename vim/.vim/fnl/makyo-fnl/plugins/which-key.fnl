;;;; Which-key configuration

(module makyo-fnl.plugins.which-key
        {require {a aniseed.core
                  nvim aniseed.nvim
                  {: normal} aniseed.nvim.util}
         autoload {utils makyo-fnl.utils
                   layers makyo-fnl.plugins.which-key.layers}})

(defn- wk-spec [{: map : cmd : opts}]
  "Creates an entry that conforms to the v3 which-key spec. These
  can take on two different forms:

  {\"<map>\" opts}
  {\"<map>\" command opts}"
  (if (a.nil? cmd)
    (a.merge [map] opts)
    (a.merge [map cmd] opts)))

(defn to-new-spec [old-spec ?prefix]
  "Takes a group of mappings that does not conform to v3 of the
  folke/which-key.nvim spec and makes them conform to the v3 spec."
  (a.reduce (fn [last vals]
              (let [[k v] vals
                    new-prefix (.. (or ?prefix "") k)]
                (if (and (a.table? v) (?. v :name))
                  (a.concat last [(wk-spec {:map (.. "<leader>" new-prefix) :opts {:group (?. v :name)}})] (to-new-spec v new-prefix))
                  (not (= k "name"))
                  (a.concat last [(wk-spec {:map (.. "<leader>" new-prefix) :cmd (a.first v) :opts {:desc (a.second v)}})])
                  last)))
            []
            (a.kv-pairs old-spec)))

(def normal-mode-layers
  (to-new-spec
    (a.merge
      layers.root-mappings
      layers.application-layer
      layers.buffer-layer
      layers.comment-and-compile-layer
      layers.file-layer
      layers.fzf-layer
      layers.version-control-layer
      layers.insertion-layer
      layers.jumps-and-folds-layer
      layers.modes-layer
      layers.project-layer
      layers.plugins-layer
      layers.search-layer
      layers.spelling-layer
      layers.toggles-layer
      layers.windows-layer
      layers.text-layer
      )))

(def visual-mode-layers
  (a.merge! {:mode "v"} (to-new-spec layers.visual-mode-layers)))

(def terminal-mode-layers
  (a.merge! {:mode "t"} (to-new-spec layers.terminal-mode-layers)))

(defn setup-mappings []
  (let [wk (utils.safe-require "which-key")
        all-layers [
                    normal-mode-layers
                    visual-mode-layers
                    terminal-mode-layers
                    ]]
    (wk.add all-layers)))
