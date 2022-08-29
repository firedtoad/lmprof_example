local lmprof = require"lmprof"

print("Hello, World!")

if true then
    print('adasdasdasdsa')
end


for i,v in pairs(package.searchers) do
    print(i,v)
end

local function f(n)
    if n > 0 then return f(n-1) end
end

local cfgLua=require("HL1V1Divisions")
local line=require("serpent").line

local function log_debug(str)
    if release then
        print(str)
    end
end

lmprof.start()
print(line(cfgLua))
lmprof.stop("stage1.lua")

lmprof.start()
function c(a)
    local t={1}
    t[a]=a
end
local a=1
local x="11111111111111111111111111111111111111111111111111111111"
c(x)
lmprof.stop("stage2.lua")