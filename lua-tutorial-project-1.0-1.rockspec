package = "lua-tutorial-project"
version = "1.0-1"
source = {
   url = "git@github.com:alfu32/lua-tutorial-project.git"
}
description = {
   homepage = "https://github.com/alfu32/lua-tutorial-project",
   license = "MIT"
}
dependencies = {
   "lua ~> 5.4"
}
build = {
   type = "builtin",
   modules = {
      ["lib.utils"] = "src/lib/utils.lua"
   },
   copy_directories = {
      "tests"
   }
}
