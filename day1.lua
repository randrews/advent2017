f = io.open('day1.txt')
str = f:read('*a'):match('%d+')
f:close()

function findsum(str)
    local sum = 0
    local count = 0
    for i = 1, #str do
        local current = tonumber(str:sub(i,i))
        local n = i+1
        if n > #str then n = n - #str end
        local next = tonumber(str:sub(n,n))
        print(current, next)
        if current == next then sum = sum + current end
    end

    return sum
end

function findsum2(str)
    local sum = 0
    local count = 0
    for i = 1, #str do
        local current = tonumber(str:sub(i,i))
        local n = i + #str/2
        if n > #str then n = n - #str end
        local next = tonumber(str:sub(n,n))
        print(current, next)
        if current == next then sum = sum + current end
    end

    return sum
end
