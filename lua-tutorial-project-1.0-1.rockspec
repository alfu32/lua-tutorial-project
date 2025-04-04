package = "lua-tutorial-project"
version = "1.0-1"
source = {
   url = "*** please add URL for source tarball, zip or repository here ***"
}
description = {
   homepage = "*** please enter a project homepage ***",
   license = "*** please specify a license ***"
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
