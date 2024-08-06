(module makyo-fnl.plugins.neorg
  {require {a aniseed.core
            nvim aniseed.nvim}
   autoload {: neorg}})

(defn init []
  (let [config {:load {"core.defaults" {}
                       "core.concealer" {}
                       "core.ui" {}
                       "core.syntax" {}
                       "core.text-objects" {}
                       "core.integrations.treesitter" {}
                       "core.neorgcmd" {}
                       "core.clipboard" {}
                       "core.integrations.coq_nvim" {}
                       "core.neorgcmd.commands.return" {}
                       "core.storage" {}}}]
    (neorg.setup config)))
