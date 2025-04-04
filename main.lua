package.path = "./src/?.lua;" .. package.path

local utils = require("lib.utils")

print(utils.greet("John"))