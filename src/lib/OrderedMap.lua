local OrderedMap = {}

OrderedMap.__index = OrderedMap
function OrderedMap.new()
    return setmetatable({
        keys = {},
        values = {}
    }, OrderedMap)
end

function OrderedMap:add(key, value)
    if self.values[key] == nil then
        table.insert(self.keys, key)
    end
    self.values[key] = value
end

function OrderedMap:remove(key)
    if self.values[key] ~= nil then
        for i, k in ipairs(self.keys) do
            if k == key then
                table.remove(self.keys, i)
                break
            end
        end
        self.values[key] = nil
    end
end

function OrderedMap:get(key)
    return self.keys[key]
end

function OrderedMap:foreach(fn)
    for index, key in ipairs(self.keys) do
        fn(index, key, self.values[key])
    end
end

function OrderedMap.test()
    local map = OrderedMap.new()

    map:add("x", 10)
    map:add("y", 20)
    map:add("z", 30)

    map:foreach(function(i, k, v)
        print(i, k, v)
    end)

    print("Value of y:", map:get("y"))

    map:remove("y")
    map:foreach(function(i, k, v)
        print(i, k, v)
    end)
end

return OrderedMap
