---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by alfu64.
--- DateTime: 8/04/2025 00:01
---

local utils = require("lib.utils")

describe(
    "utils.greet",
    function()
        it(
                "returns a proper greeting",
                function()
                    assert.is_equal(utils.greet("Paul"), "Hello, Paul!")
                end
        )
    end
)