(import-macros {: module
                : def}
               :nfnl.macros.aniseed)

(module makyo-fnl.plugins.which-key.layers.visual.version-control)

(def visual-version-control-layer
  {
   :g {
       :name "+version-control"
       :u {
           :name "+url"
           :b [#(nvim.cmd {:cmd "lua require\"gitlinker\".get_buf_range_url(\"v\", {action_callback = require\"gitlinker.actions\".open_in_browser})<cr>"}) "buf range URL"]
           }}})
