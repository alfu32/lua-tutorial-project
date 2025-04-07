package.path = "./src/?.lua;" .. package.path

local Dog = {}
Dog.__index = Dog
function Dog:new(name)
  local o = setmetatable({}, self)
  o.name = name
  return o
end
function Dog:speak()
  print(self.name .. " says woof!")
end
local myDog = Dog:new("Buddy")
myDog:speak() -- Buddy says woof!


local OrderedMap = require("lib.OrderedMap")

local ExampleRunner = {}
ExampleRunner.__index = ExampleRunner
setmetatable(ExampleRunner, { __index = OrderedMap })

function ExampleRunner.new()
    return setmetatable(OrderedMap.new(), ExampleRunner)
end

function ExampleRunner:run(skipped_keys)
    function contains(tbl, value)
        for _, v in ipairs(tbl) do
            if v == value then return true end
        end
        return false
    end
    local r = 1
    local chapter_template="=-%02d-%-40s -                                   -==="
    local line="===-==========================================-======================================="
    self:foreach(function (i,n,f)
        local f = self.values[n]
        print(line)
        print(string.format(chapter_template,r,n))
        print(line)
        print("--------------------------------------------------------------------------------------")
        if contains(skipped_keys,n) then
            print("skipping ... ")
            goto continue
        end
        f()
        ::continue::
        r=r+1
    end)
end

local funcs=ExampleRunner.new()

funcs:add("00-exercise-01",function()
    local utils = require("lib.utils")
    print(utils.greet("John"))
end)

funcs:add("00-exercise-02",function()
    local utils0101 = require("src.lib.utils_ex_01_01")
    print(utils0101.add(1,2))
end)

funcs:add("00-exercise-03",function()
    local utils0101 = require("src.lib.utils_ex_01_01")
    for i = 1, 10 do
        print("[" .. i .. "] = " .. utils0101.factorial(i))
    end
end)


funcs:add("00-exercise-04-benchmark-loop",function()
    print("counting")
    local x=0
    for i = 1,1e6 do
        -- io.write ("\r" .. i)
        x=i
        if (x % 10) == 0 then
            io.write ("\r" .. i)
        end
    end
    print("\ndone counting")
end)

funcs:add("01.1-example-001-multiline-strings",function()
    local s1 = "double quoted\n"
    local s2 = 'single quoted\n'
    local s3 = [[
    Multi-line
    String\n
    ]]
    print(s1)
    print(s2)
    print(s3)
end)


funcs:add("01.1-example-002-dynamic-typing",function()
    local n = "123"
    print(tonumber(n) + 10)  --> 133
    local b = 1
    if b then 
        print("truthy")
    end  --> prints`
end)

funcs:add("01.1-example-003-input-output",function()
    print("Enter your name:")
    local name = io.read()
    print("Hello, " .. name)
end)

funcs:add("01.1-exercise-001-print-primitive-values",function()
    print(string.format("type of 'nil' = %s",type(nil)))
    print(string.format("type of 'true' = %s",type(true)))
    print(string.format("type of '42' = %s",type(42)))
    print(string.format("type of 'hi' = %s",type("hi")))
    print(string.format("type of '{}' = %s",type({})))
    print(string.format("type of 'function() end' = %s",type(function() end)))
    
end)

funcs:add("01.1-exercise-002-describe-function",function()
    function describe(v)
        local truthy=true
        if v then truthy = true else truthy = false end
        s=string.format("{truthy:%s, type:%s}",truthy,type(v))
        -- print(s)
        return s
    end
    print(string.format("describe(nil) = %s",describe(nil)))
    print(string.format("describe(true) = %s",describe(true)))
    print(string.format("describe(false) = %s",describe(false)))
    print(string.format("describe(0) = %s",describe(0)))
    print(string.format("describe(42) = %s",describe(42)))
    print(string.format("describe('') = %s",describe("")))
    print(string.format("describe('hi') = %s",describe("hi")))
    print(string.format("describe({}) = %s",describe({})))
    print(string.format("describe(function() end) = %s",describe(function() end)))
end)

funcs:add("01.1-exercise-003-parse-int",function()
    print("Enter a number:")
    local input = io.read()
    print(tonumber(input) * 10)  --> 125.0`
    print("Enter another number:")
    local num = io.read('n')
    print(num * 10)  --> 125.0`
end)

funcs:add("01.1-exercise-004-string-concatenation",function()
    local first = "Lua"
    local second = "Rocks"
    print(first .. " " .. second)
end)

funcs:add("01.1-exercise-005-string-to-uppercase",function()
    print("Enter text:")
    local text = io.read()
    print(string.upper(text))
end)

funcs:add("01.1-exercise-extra-quadratic-solutions",function()
    local function solutions(a,b,c)
        local d = b*b - 4*a*c
        local x1=nil
        local x2=nil
        if d<0 then
            local fmt = "%s %s ị·%s"
            x1 = string.format(fmt,b/2/a,'-',math.sqrt(-d)/2/a)
            x2 = string.format(fmt,b/2/a,'+',math.sqrt(-d)/2/a)
        else
            x1=(b+math.sqrt(d))/2/a
            x2=(b-math.sqrt(d))/2/a
        end
        return x1,x2
    end
    io.write("choose a,b,c coefficients of a·x²+b·x+c = 0 : ")
    local a = io.read('n')
    io.write(a .. " · x² + ")
    local b = io.read('n')
    io.write("\27[A" .. a .. " · x² + " .. b .. " · x + ")
    local c = io.read('n')
    io.write() 
    io.write("\27[A" .. a .. " · x² + " .. b .. " · x + " .. c .. " = 0")
    local x1,x2 = solutions(a,b,c)
    print(string.format("\nx1 = %s ",x1))
    print(string.format("x2 = %s ",x2))
end)


funcs:add("01.2-example-001-tables",function()
    local t = {}             -- empty table
    t["name"] = "Paul"       -- string key
    t.age = 42               -- sugar for t["age"]
    t[1] = "first element"   -- numeric index (array-style)`
end)

funcs:add("01.2-example-002-tables-inline",function()
    local user = {
        name = "John",
        age = 30,
        skills = { "Lua", "C", "JS" }
    }
end)

funcs:add("01.2-example-003-arrays",function()
    local fruits = { "apple", "banana", "cherry" }
    print(fruits[2]) -- banana
end)
funcs:add("01.2-example-004-dictionaries",function()
    local config = {
        port = 8080,
        host = "localhost"
    }
end)
funcs:add("01.2-example-005-mixed",function()
    local t = {
        "index0", "index1",
        foo = "bar",
        [true] = "yes"
    }
end)

funcs:add("01.2-example-006-metatables-metamethods",function()
    
    local a = { x = 1 }
    local b = { y = 2 }
    print(a.x or 0,a.y or 0)
    print(b.x or 0,b.y or 0)
    local mt = {
        __add = function(lhs, rhs)
            local xx = (lhs.x or 0) + (rhs.x or 0)
            local yy = (lhs.y or 0) + (rhs.y or 0)
            return { x = xx, y = yy }
        end
    }
    setmetatable(a, mt)
    setmetatable(b, mt)
    local c = a + b
    print(c.x, c.y) -- 1, 2
end)

funcs:add("01.2-example-007-deepcopy",function()
    function deepcopy(orig)
        local copy = {}
        for k, v in pairs(orig) do
            if type(v) == "table" then
                copy[k] = deepcopy(v)
            else
                copy[k] = v
            end
        end
        return copy
    end
    local a = {a=1,b=2}
    local b = a
    local c = {a=1,b=2}
    local d = deepcopy(c)
    print(" a == b   -> %s",a == b)
    print(" a == c   -> %s",a == c)
    print(" c == d   -> %s",c == d)
end)

funcs:run({
    "01.1-example-003-input-output",
    "01.1-exercise-003-parse-int",
    "01.1-exercise-extra-quadratic-solutions",
    "01.1-exercise-005-string-to-uppercase",
})

