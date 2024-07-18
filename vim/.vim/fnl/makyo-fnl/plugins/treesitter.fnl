;;; Configures everything dealing with Treesitter
(module makyo-fnl.plugins.treesitter
  {autoload {a aniseed.core
             ts nvim-treesitter.configs
             tsp nvim-treesitter.parsers}})

(defn- setup []
  "Configures treesitter"
  (ts.setup {:ensure_installed ["lua"
                                "luap"
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
                         :additional_vim_regex_highlighting false}
             :indent {:enable true}
             :incremental_selection {:enable true
                                     :init_selection "gnn"
                                     :node_incremental "grn"
                                     :scope_incremental "grc"
                                     :node_decremental "grm"}
             ;; Plugin support
             :autotag {:enable true}
             :textsubjects {:enable true
                            :prev_selection ","
                            :keymaps {"." "textsubjects_smart"
                                      ";" "textsubjects_container_outer"
                                      "i;" "textsubjects_container_inner"}}}))

(defn- setup-parser-configs []
  (let [pc (tsp.get_parser_configs)]
    (set pc.tsx.used_by ["javascript" "typescript.tsx"])))

(defn init []
  (do
    (a.println "[makyo][plugins][treesitter] Setting up ...")

    (setup)
    (setup-parser-configs)

    (a.println "[makyo][plugins][treesitter] Done.")))
