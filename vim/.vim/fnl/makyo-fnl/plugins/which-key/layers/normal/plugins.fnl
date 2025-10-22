(module makyo-fnl.plugins.which-key.layers.normal.plugins
    {autoload {utils makyo-fnl.plugins.which-key.utils}})

(def plugins-layer
  {
   :P {
       :name "+plugins"
       :C ["<cmd>Lazy clean<cr>" "clean"]
       :h ["<cmd>Lazy home<cr>" "home"]
       :i [#(utils.prompt-and-run "Plugin to install: " ":Lazy install ") "install plugin"]
       :l ["<cmd>Lazy log<cr>" "log"]
       :u ["<cmd>Lazy update<cr>" "update"]
       :w {
           :name "+which-key"
           :e ["<cmd>tabnew ~/.vim/fnl/makyo-fnl/plugins/which-key.fnl<cr>" "edit mappings"]
           }
       }
   })
