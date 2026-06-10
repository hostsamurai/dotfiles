(module makyo-fnl.init
  {require {providers makyo-fnl.providers
            plugins makyo-fnl.plugins
            ux makyo-fnl.ux
            ui makyo-fnl.ui
            colors makyo-fnl.colors
            fns makyo-fnl.functions
            autocmds makyo-fnl.autocmds
            mappings makyo-fnl.mappings
            a aniseed.core}})

(defn init []
  (do
    (providers.init)
    (plugins.init)
    (autocmds.init)
    (ux.init)
    (ui.init)
    (colors.init)
    (fns.init)
    (mappings.init)
    (a.println "[makyo] Makyo startup complete")))

(init)
