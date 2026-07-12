(import-macros {
                : module
                : defn-
                : defn
                : def-
                : def
                }
                :nfnl.macros.aniseed)

(module :makyo-fnl.plugins.luasnip)

(def- personal-snippets-directory (.. (vim.fn.stdpath "config") "/snippets"))

(defn get-luasnip-loaders []
  (let [ls (require :luasnip.loaders)]
    ls))

(defn get-luasnip []
  (let [ls (require :luasnip)]
    ls))

(defn- open-snippet-file [ft paths]
  (vim.print paths)
  (if (= (length paths) 0)
    [[(.. "$CONFIG/" ft ".snippets") (string.format "%s/%s.snippets" personal-snippets-directory ft)]]
    []))

(defn call-edit-snippet-files-with-more-choices []
  (let [loader (get-luasnip-loaders)]
    (loader.edit_snippet_files {:extend open-snippet-file})))

(defn create-edit-snippets-command []
  (vim.api.nvim_create_user_command "LuaSnipEdit" call-edit-snippet-files-with-more-choices {:bang false}))
