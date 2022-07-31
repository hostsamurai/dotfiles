;;;; Autocmd declarations

(module makyo-fnl.autocmds
  {require {a aniseed.core
            compile aniseed.compile
            nvim aniseed.nvim}})

(defn- to-transpiled-filename [filename]
  "Takes a Fennel source filename and returns its Lua counterpart."
  (-> filename
      (string.gsub "/fnl/" "/lua/")
      (string.gsub "[.]fnl" ".lua")))

(defn- create-plugin-config-refresh-autocmd []
  "Refresh plugin configuration after modifying it."
  (let [setup-file "~/.vim/fnl/makyo-fnl/plugins/setup.fnl"
        transpiled-setup-file (to-transpiled-filename setup-file)]
    (nvim.create_autocmd ["BufWritePost"]
                        {:pattern setup-file
                         :callback #(do
                                      (compile.file setup-file transpiled-setup-file)
                                      (nvim.command "PackerCompile"))})))

(defn- create-shortcuts-refresh-autocmd []
  "Refresh which_key shortcuts."
  (let [shortcuts-file "~/.vim/fnl/makyo-fnl/plugins/which-key.fnl"
        transpiled-shortcuts-file (to-transpiled-filename shortcuts-file)]
    (nvim.create_autocmd ["BufWritePost"]
                         {:pattern shortcuts-file
                          :callback #(do
                                       (compile.file shortcuts-file transpiled-shortcuts-file)
                                       (nvim.ex.source transpiled-shortcuts-file))})))

(defn- create_general_autocmds []
  (do
    (create-plugin-config-refresh-autocmd)
    (create-shortcuts-refresh-autocmd)))

(defn init []
  (do
    (a.println "[makyo] 🚗 Creating autocommands...")
    (create_general_autocmds)
    (a.println "[makyo] 🚗 Done.")))
