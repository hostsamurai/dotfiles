;;; Configures everything dealing with Treesitter
(module makyo-fnl.plugins.treesitter
  {autoload {a aniseed.core
             ts nvim-treesitter.configs
             tsp nvim-treesitter.parsers}})

(defn- setup []
  "Configures treesitter"
  (ts.setup {:ensure-installed ["lua"
                                "lua patterns"
                                "vim"
                                "vimdoc"
                                "clojure"
                                "commonlisp"
                                "fennel"
                                "http"
                                "javascript"
                                "typescript"
                                "html"
                                "css"
                                "scss"
                                "ruby"]
             :highlight {:enable true
                         :disable ["racket" "scheme"]
                         :additional-vim-regex-highlighting false}
             :indent {:enable true}
             :incremental-selection {:enable true
                                     :init-selection "gnn"
                                     :node-incremental "grn"
                                     :scope-incremental "grc"
                                     :node-decremental "grm"}
             ;; Plugin support
             :autotag {:enable true}
             :textsubjects {:enable true
                            :prev_selection ","
                            :keymaps {"." "textsubjects-smart"
                                      ";" "textsubjects-container-outer"
                                      "i;" "textsubjects-container-inner"}}}))

(defn- setup-parser-configs []
  (let [pc (tsp.get_parser_configs)]
    (set pc.tsx.used_by ["javascript" "typescript.tsx"])))

(defn init []
  (do
    (a.println "[makyo][plugins][treesitter] Setting up ...")

    (setup)
    (setup-parser-configs)

    (a.println "[makyo][plugins][treesitter] Done.")))
