local lmprof = require"lmprof"

local function f(n)
    if n > 0 then return f(n-1) end
end
local cfgLua=require("HL1V1Divisions")
local line=require("serpent").line
lmprof.start()
print(line(cfgLua))
lmprof.stop("stage1.lua")

-- lmprof.start()
-- print(require("serpent"))
-- lmprof.stop("stage2.lua")