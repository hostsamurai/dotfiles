;;;; Autocmd declarations

(import-macros {: module
                : def
                : defn-
                : defn}
               :nfnl.macros.aniseed)
(import-macros {: when-let} :nfnl.macros)

(module makyo-fnl.autocmds)

(local {: println : get-in} (require :nfnl.core))
(local nvim (require :nvim))
(local {: setup-mappings} (require :makyo-fnl.plugins.which-key))
(local colors (require :makyo-fnl.colors))
(local {: config} (require :makyo-fnl.config))

;;; Makyo-specific functions

(def makyo-augroup (nvim.create_augroup "makyo.events" {:clear true}))

(defn apply-config []
  (when-let [colorscheme (get-in config [:colorscheme])]
    (nvim.exec_autocmds "User" {
                                :group makyo-augroup
                                :pattern "MakyoColorScheme"
                                :modeline false
                                :data {:colorscheme colorscheme}
                                })))

(defn- create-set-colorscheme-autocmd []
  "Creates a custom `autocmd` for changing the color scheme."
  (nvim.create_autocmd ["User"]
                       {
                        :group makyo-augroup
                        :pattern "MakyoColorScheme"
                        :callback (fn [event]
                                    (let [colorscheme (get-in event [:data :colorscheme])]
                                      (nvim.ex.colorscheme colorscheme)
                                      (nvim.command "IndentEnable")
                                      (colors.tweak-color-scheme)))
                        }))

(defn- create-makyo-initialization-done-autocmd []
  "Sets up an `autocmd` that fires after all of the Makyo modules
   have been loaded. It reads the config found in the `makyo-fnl.config`
   module."
  (nvim.create_autocmd ["UIEnter"] {:callback apply-config}))

(defn- register-makyo-autocmds []
  (do
    (create-makyo-initialization-done-autocmd)
    (create-set-colorscheme-autocmd)))

;;; General purpose functions

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
  "Refresh which-key shortcuts."
  (let [shortcuts-file "**/makyo-fnl/plugins/which-key/layers.fnl"
        transpiled-shortcuts-file (to-transpiled-filename shortcuts-file)]
    (nvim.create_autocmd ["BufWritePost"]
                         {:pattern shortcuts-file
                          :callback #(do
                                       (nvim.echo "Refreshing shortcuts...")
                                       (setup-mappings))})))

(defn- create-autoupdate-airline-theme-autocmd []
  "Updates the airline theme for certain color schemes"
  (nvim.create_autocmd ["ColorScheme"]
                       {:pattern "*"
                        :callback #(colors.tweak-color-scheme)}))

(defn- auto-apply-wezterm-config-changes []
 "Transpiles weztern.fnl to wezterm.lua and places it in the
  appropriate directory so wezterm can automatically pick up the
  changes."
 (let [config-path "configs/.config/wezterm/"
       src-file (. config-path "wezterm.fnl")
       dest-file (. config-path "wezterm.lua")]
  (nvim.create_autocmd ["BufWritePost"]
                       {:pattern src-file
                        :callback #(compile.file src-file dest-file)})))

(defn- create_general_autocmds []
  (do
    (register-makyo-autocmds)
    (create-plugin-config-refresh-autocmd)
    (create-shortcuts-refresh-autocmd))
    (create-autoupdate-airline-theme-autocmd))

(defn init []
  (do
    (println "[makyo] 🚗 Creating autocommands...")
    (create_general_autocmds)
    (println "[makyo] 🚗 Done.")))
