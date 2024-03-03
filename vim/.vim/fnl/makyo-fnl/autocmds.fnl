;;;; Autocmd declarations

(module makyo-fnl.autocmds
  {autoload {a aniseed.core
             compile aniseed.compile
             nvim aniseed.nvim
             {: setup-which-key-mappings} makyo-fnl.mappings}
   import-macros [[ac :aniseed.macros.autocmds]]})

(defn- to-transpiled-filename [filename]
  "Takes a Fennel source filename and returns its Lua counterpart."
  (-> filename
      (string.gsub "/fnl/" "/lua/")
      (string.gsub "[.]fnl" ".lua")))

(defn- create-plugin-config-refresh-autocmd []
  "Refresh plugin configuration after modifying it."
  (let [setup-file "**/makyo-fnl/plugins/setup.fnl"
        transpiled-setup-file (to-transpiled-filename setup-file)]
    (nvim.create_autocmd ["BufWritePost"]
                        {:pattern setup-file
                         :callback #(do
                                      (compile.file setup-file transpiled-setup-file)
                                      (nvim.command "PackerCompile"))})))

(defn- create-shortcuts-refresh-autocmd []
  "Refresh which_key shortcuts."
  (let [shortcuts-file "**/makyo-fnl/plugins/which-key.fnl"
        transpiled-shortcuts-file (to-transpiled-filename shortcuts-file)]
    (nvim.create_autocmd ["BufWritePost"]
                         {:pattern shortcuts-file
                          :callback #(do
                                       (nvim.echo "Refreshing shortcuts...")
                                       (nvim.set_var "which_key_map" {})
                                       (nvim.set_var "which_key_map_visual" {})
                                       (setup-which-key-mappings))})))

(defn- create-ts-fold-workaround-autocmd []
  "Avoid the \"No folds found\" error when initializing treesitter
  through packer.nvim"
  (ac.augroup :TS_FOLD_WORKAROUND
              [[:BufEnter :BufAdd :BufNew :BufNewFile :BufWinEnter]
               {:callback #(do
                             (nvim.o.foldmethod "expr")
                             (nvim.o.foldexpr "nvim_treesitter#foldexpr()"))}]))

(defn- create_general_autocmds []
  (do
    (create-plugin-config-refresh-autocmd)
    (create-shortcuts-refresh-autocmd)))

(defn init []
  (do
    (a.println "[makyo] 🚗 Creating autocommands...")
    (create_general_autocmds)
    (a.println "[makyo] 🚗 Done.")))
