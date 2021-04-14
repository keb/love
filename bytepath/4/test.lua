local inspect = require 'lib/inspect'
local lume = require 'lib/lume'

local x = { a = 2 }
local opts = { b = 2, c = 3 }
local comb = lume.merge(x, opts)

print(
    inspect(comb)
)