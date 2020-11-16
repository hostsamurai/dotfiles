package = "lua"
version = "dev-1"
source = {
   url = "git+ssh://git@github.com/hostsamurai/dotfiles.git"
}
description = {
   homepage = "*** please enter a project homepage ***",
   license = "*** please specify a license ***"
}
build = {
   type = "builtin",
   modules = {
      init = "init.lua",
      ["makyo.mappings"] = "makyo/mappings.lua",
      ["makyo.plugins"] = "makyo/plugins.lua",
      ["makyo.plugins.denite"] = "makyo/plugins/denite.lua",
      ["makyo.plugins.fzf"] = "makyo/plugins/fzf.lua",
      ["makyo.plugins.which_key"] = "makyo/plugins/which_key.lua",
      ["makyo.ui"] = "makyo/ui.lua",
      ["makyo.ux"] = "makyo/ux.lua"
   }
}
