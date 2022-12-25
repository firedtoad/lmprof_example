-- local profiler= require("callgrind")
local lmprof = require"lmprof"
local Profiler = require("PepperfishProfiler")
profiler = newProfiler("call")
profiler:start()
-- profiler.start("test")
print("Hello, World!")

-- SLOG_DEBUG(1,
-- print)


for i,v in pairs(package.searchers) do
    print(i,v)
end

local function f(n)
    if n > 0 then return f(n-1) end
end

local cfgLua=require("HL1V1Divisions")

local function log_debug(str)
    if release then
        print(str)
    end
end

local function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
    return tostring(o)
   end
end
local m = {
    _TYPENAME = "class"
}
function m:new(...)
    local t = {}
    setmetatable(t, {
        __index = self
    })
    if t.Ctor then
        t:Ctor(...)
    end
    return t
end

m.__index = m

function class(f)
    return setmetatable({}, {
        __index = f or m
    })
end
function GetFunInfo()
    local info = debug.getinfo(3, "Sln")
    if not info then
        return "", "", 0
    end
    return info.short_src or "", info.name or "[main trunk]", info.currentline or 0
end

function SLOG_INFO(qwUserID, str)
    if 1 then
        LuaSlog(str)
    end
end

CServerOpenDays = class()
function CServerOpenDays:Ctor()
    -- 部分活动的开服时间需要在活动开始的时候记录，以此调整推荐战力，避免活动周期内变化
    -- 该table是内存缓存值，从redis获取，redis没有就获取当前开服天数并保存redis
    -- 格式：[activityid] = timestamp
    self.m_serverOpenDays = {}
end

function CServerOpenDays:OnAfterInitTimer()
    SLOG_INFO(0, "[ServerOpenDay] OnAfterInitTimer...")
end

function TryCall(func, ...)
    return pcall(func, function(err)
        SLOG_INFO(0, "pcall failed " .. err)
    end, ...)
end

-- lmprof.start()
-- print(require("serpent").line(cfgLua[1]))
-- print(require("serpent").line(cfgLua[1]))
-- print(require("serpent").line(cfgLua[1]))
-- print(require("serpent").line(cfgLua[1]))
-- print(require("serpent").dump(cfgLua))
-- print(require("inspect").inspect(cfgLua[1]))
 local t={
  [8001] = {
    ActiveGift = {
      6991609029181063172,
      6991609029181222223322.4456,
      30000010,
      30000014
    },
    BackflowGift = {
      30000001,
      30000002,
      30000003,
      30000006,
      30000007,
      30000008,
      30000010,
      30000011,
      30000012,
      30000013,
      30000014
    }
  }
}

print(cjson.encode('a'))
print(cjson.encode_sparse_array(true))
print(cjson.encode(t))
print(require("serpent").block(cfgLua))



-- lmprof.stop("stage1.lua")

lmprof.start()

local a=1
local x="11111111111111111111111111111111111111111111111111111111"
local open=CServerOpenDays:new()
-- open:OnAfterInitTimer()
function ff()
    TryCall(open.OnAfterInitTimer)
end
ff()


lmprof.stop("stage2.lua")

profiler:stop()
local outfile = io.open( "profile.txt", "w+" )
profiler:report( outfile )
outfile:close()