local M = require 'macro'

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
M.define 'HELLO "Hello, World!"'
-- macro.define('SLOG_DEBUG(uuid,expr)if true then\n    print(uuid,expr)\nend\n')
M.define('SLOG_DEBUG(uuid,expr)',function(n,x)
    print(dump(M))
    print(M)
    print(n,x)
end)