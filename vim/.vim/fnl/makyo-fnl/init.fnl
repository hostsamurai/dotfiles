(module makyo-fnl.init
  {require {providers makyo-fnl.providers
            plugins makyo-fnl.plugins
            ux makyo-fnl.ux
            ui makyo-fnl.ui
            fns makyo-fnl.functions
            mappings makyo-fnl.mappings}})

(defn init [] 
  (do 
      (providers.init)
      (plugins.init)
      (ux.init)
      (ui.init)
      (fns.init)
      (mappings.init)))
