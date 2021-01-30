(module makyo-fnl.demo
  {require {a aniseed.core
            nvim aniseed.nvim
            providers makyo-fnl.providers
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
