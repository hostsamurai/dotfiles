package = "makyo"
version = "dev-1"
source = {
   url = "git+ssh://git@github.com/hostsamurai/dotfiles.git"
}
description = {
   homepage = "*** please enter a project homepage ***",
   license = "*** please specify a license ***"
}
dependencies = {
    "moses >= 2.1",
    "compat53 >= 0.8"
}
build = {
   type = "builtin",
   modules = {
      init = "init.lua",
      ["makyo.plugins"] = "makyo/plugins.lua",
      ["makyo.plugins.transform"] = "makyo/plugins/transform.lua"
   }
}
