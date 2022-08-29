local macro = require 'macro'
macro.define 'HELLO "Hello, World!"'
macro.define('LOG_DEBUG(expr)if true then\n    print(expr)\nend\n')
