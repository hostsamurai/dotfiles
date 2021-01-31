(module makyo-fnl.init
  {require {providers makyo-fnl.providers
            plugins makyo-fnl.plugins
            ux makyo-fnl.ux
            ui makyo-fnl.ui
            fns makyo-fnl.functions
            mappings makyo-fnl.mappings}})

(do 
  (providers.init)
  (plugins.init)
  (ux.init)
  (ui.init)
  (fns.init)
  (mappings.init))
