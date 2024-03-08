(module makyo-fnl.init
  {require {providers makyo-fnl.providers
            plugins makyo-fnl.plugins
            ux makyo-fnl.ux
            ui makyo-fnl.ui
            colors makyo-fnl.colors
            fns makyo-fnl.functions
            autocmds makyo-fnl.autocmds
            mappings makyo-fnl.mappings}})

(defn init []
  (do
    (providers.init)
    (plugins.init)
    (ux.init)
    (ui.init)
    (colors.init)
    (fns.init)
    (autocmds.init)
    (mappings.init)))

(init)
