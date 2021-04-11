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
      ["makyo.plugins"] = "makyo/plugins.lua",
      ["makyo.plugins.transform"] = "makyo/plugins/transform.lua"
   }
}
