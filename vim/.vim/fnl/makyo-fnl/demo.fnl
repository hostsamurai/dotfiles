(module makyo-fnl.demo
  {require {a aniseed.core
            nvim aniseed.nvim
            providers makyo-fnl.providers
            ux makyo-fnl.ux
            ui makyo-fnl.ui
            fns makyo-fnl.functions
            mappings makyo-fnl.mappings}})

(do 
  (providers.init)
  (ux.init)
  (ui.init)
  (fns.init)
  (mappings.init))
