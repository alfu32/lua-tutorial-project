local utils={}

function utils.add(a, b)
    return a + b
end

function utils.factorial(n)
    if n==1 then
        return 1
    else
        return n*utils.factorial(n-1)
    end
end

return utils