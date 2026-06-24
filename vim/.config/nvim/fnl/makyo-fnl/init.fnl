(import-macros {: module
                : def
                : defn
                }
                :nfnl.macros.aniseed)

(module makyo-fnl.init)

(local {: println} (require :nfnl.core))
(local providers (require :makyo-fnl.providers))
(local plugins (require :makyo-fnl.plugins))
(local ux (require :makyo-fnl.ux))
(local ui (require :makyo-fnl.ui))
(local colors (require :makyo-fnl.colors))
(local fns (require :makyo-fnl.functions))
(local autocmds (require :makyo-fnl.autocmds))
(local mappings (require :makyo-fnl.mappings))

(defn init []
  (do
    (providers.init)
    (autocmds.init)
    (plugins.init)
    (ux.init)
    (ui.init)
    (fns.init)
    (mappings.init)
    (colors.init)
    (println "[makyo] Makyo startup complete")))

(init)
