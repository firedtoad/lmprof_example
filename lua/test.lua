local lmprof = require"lmprof"
local function foo (n)
    if n <0 then
        return 0
    end
     return foo(n - 1)
end
lmprof.start()
foo(123,2001)
lmprof.stop("stage1.lua")

lmprof.start()
print(require("serpent"))
lmprof.stop("stage2.lua")