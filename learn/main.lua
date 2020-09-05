num = 0

-- while num < 50 do
--     num = num + 1
--     -- print(num)
-- end

if num > 40 then
    print('over 40')
elseif num ~= 0 then
    print('num does not equal 0')
else
    print('num is equal to 0')
    -- variables are global by default
    thisIsGlobal = 5
    -- how to make a variable local
    local foo = 4

    -- string concatenation uses the .. operator
    print('winter is coming, ' .. foo)
end

-- Only nil and false are falsy; 0 and '' are true!

-- or and and are short circuited
-- this is similar to the ternary operator
ans = true and 'yes' or 'no' --> no

-- loops
karlSum = 0
for i = 1, 100 do -- the range includes both ends (1, 100)
    karlSum = karlSum + i
end

print(karlSum)

-- use 100, 1, -1 as the range to count down
fredSum = 0
for j = 100, 1, -1 do fredSum = fredSum + j end

print(fredSum)

-- another loop construct
fum = 3
repeat
    print('the way of the future')
    fum = fum - 1
until fum == 0

-- Functions

function fib(n)
    if n < 2 then return 1 end
    return fib(n - 2) + fib(n - 1)
end

-- Closures and anonymous functions are ok:
function adder(x)
    return function(y) return x + y end
end

addNine = adder(9)
print( addNine(8) ) --> 17

-- returns func calls and assignments all work with lists that may be mismatched in length
x, y, z = 1, 2, 3, 4
-- 4 is thrown away cuz there is no match

function bar(a, b, c)
    print(a, b, c)
    return 4, 8, 7
end

x, y = bar('potato') --> prints "potato nil nil"
-- x is 4 now and y is 8, while 7 is discarded

-- functions are first-class and may be local/global
-- these are the same
function f(x) return x * x end
f = function (x) return x * x end

-- so are these
local function g(x) return math.sin(x) end
local g; g = function (x) return math.sin(x) end
-- the 'local g' decl makes g-self-references OK

-- calls with one string param dont need parens
print 'hello'

-- Tables
-- Luas only compound data structure

-- dict literals have string keys by default
t = { key1 = 'value1', key2 = false }

-- String keys can use js-like dot notation
print(t.key1)
t.newKey = {} -- add new key
t.key2 = nil -- remove key from table

-- literal notation for any (non-nil) value as key
u = {['@!#'] = 'qbert', [{}] = 1792, [6.28] = 'tau'}
print(u[6.28]) -- prints 'tau'

a = u['@!#'] -- now a is equal to qbert
b = u[{}] -- you might expect 1792, but it's nil because it's not the same object used to store the original value

-- a one-table-param function call needs no parens
function h(x) print(x.key1) end
h{key1 = 'potato'} -- prints potato

-- table iteration
for key, val in pairs(u) do
    print(key, val)
end

-- _G is a special table of all globals
print(_G['_G'] == _G) -- prints true

-- tables as lists or arrays
v = {'val1', 'val2', 1.21, 'gigwatts'}

for i = 1, #v do -- #v is the size of v for lists
    print(v[i])
end

-- a list is not a real type. v is just a table
-- with consecutive integer keys, treated as a list

--
-- meta tables
--

f1 = { a = 1, b = 2 }
f2 = { a = 2, b = 3 }

metafraction = {}
function metafraction.__add(f1, f2)
    sum = {}
    sum.b = f1.b * f2.b
    sum.a = f1.a * f2.b + f2.a * f1.b
    return sum
end

setmetatable(f1, metafraction)
setmetatable(f2, metafraction)

s = f1 + f2 -- calls __add(f1, f2) on f1's metatable

--[[
    Adding two ['s and ]'s makes it a
    multi-line comment.

    f1 and f2 have no key for their metatable, unlike prototypes in js
    so you must retrieve it as in getmetatable(f1)
    the metatable is a normal table with keys that Lua konws about, like __add

    this line would fail though, because s has no metatable:
    t = s + s
--]]

-- an __index on a metatable overloads dot lookups
defaultFavs = {animal = 'gru', food = 'donuts'}
myFavs = {food = 'pizza'}

setmetatable(myFavs, {__index = defaultFavs})
eatenBy = myFavs.animal -- works! thanks, metatable

-- Direct table lookups that fail will retry using
-- the metatables __index value, and this recurses

-- An __index value can also be a function(tb1, key)
-- for more customized lookups

-- values of __index, add, .. are called metamethods
-- full list:
-- __add(a, b)                     for a + b
-- __sub(a, b)                     for a - b
-- __mul(a, b)                     for a * b
-- __div(a, b)                     for a / b
-- __mod(a, b)                     for a % b
-- __pow(a, b)                     for a ^ b
-- __unm(a)                        for -a
-- __concat(a, b)                  for a .. b
-- __len(a)                        for #a
-- __eq(a, b)                      for a == b
-- __lt(a, b)                      for a < b
-- __le(a, b)                      for a <= b
-- __index(a, b)  <fn or a table>  for a.b
-- __newindex(a, b, c)             for a.b = c
-- __call(a, ...)                  for a(...)

--
-- class like tables and inheritance
--

-- explanation for this example is below it
Dog = {}
function Dog:new()
    newObj = { sound = 'woof' }
    self.__index = self
    return setmetatable(newObj, self)
end

function Dog:makeSound()
    print('I say ' .. self.sound)
end

mrDog = Dog:new()
mrDog:makeSound() -- 'I say woof'

-- 1. Dog acts like a class; it's really a table.
-- 2. function tablename:fn(...) is the same as
--    function tablename.fn(self, ...)
--    The : just adds a first arg called self.
--    Read 7 & 8 below for how self gets its value.
-- 3. newObj will be an instance of class Dog.
-- 4. self = the class being instantiated. Often
--    self = Dog, but inheritance can change it.
--    newObj gets self's functions when we set both
--    newObj's metatable and self's __index to self.
-- 5. Reminder: setmetatable returns its first arg.
-- 6. The : works as in 2, but this time we expect
--    self to be an instance instead of a class.
-- 7. Same as Dog.new(Dog), so self = Dog in new().
-- 8. Same as mrDog.makeSound(mrDog); self = mrDog.

-- inheritance example

LoudDog = Dog:new()

function LoudDog:makeSound()
    s = self.sound .. ' '
    print (s .. s .. s)
end

seymour = LoudDog:new()
seymour:makeSound() -- 'woof woof woof'

-- 1. LoudDog gets Dog's methods and variables.
-- 2. self has a 'sound' key from new(), see 3.
-- 3. Same as LoudDog.new(LoudDog), and converted to
--    Dog.new(LoudDog) as LoudDog has no 'new' key,
--    but does have __index = Dog on its metatable.
--    Result: seymour's metatable is LoudDog, and
--    LoudDog.__index = LoudDog. So seymour.key will
--    = seymour.key, LoudDog.key, Dog.key, whichever
--    table is the first with the given key.
-- 4. The 'makeSound' key is found in LoudDog; this
--    is the same as LoudDog.makeSound(seymour).

function LoudDog:new()
    newObj = {}
    -- set up newObj
    self.__index = self
    return setmetatable(newObj, self)
end

--
-- modules
--

--[[ I'm commenting out this section so the rest of
--   this script remains runnable.

-- Suppose the file mod.lua looks like this:
local M = {}

local function sayMyName()
  print('Hrunkner')
end

function M.sayHello()
  print('Why hello there')
  sayMyName()
end

return M

-- Another file can use mod.lua's functionality:
local mod = require('mod')  -- Run the file mod.lua.

-- require is the standard way to include modules.
-- require acts like:     (if not cached; see below)
local mod = (function ()
  <contents of mod.lua>
end)()
-- It's like mod.lua is a function body, so that
-- locals inside mod.lua are invisible outside it.

-- This works because mod here = M in mod.lua:
mod.sayHello()  -- Says hello to Hrunkner.

-- This is wrong; sayMyName only exists in mod.lua:
mod.sayMyName()  -- error

-- require's return values are cached so a file is
-- run at most once, even when require'd many times.

-- Suppose mod2.lua contains "print('Hi!')".
local a = require('mod2')  -- Prints Hi!
local b = require('mod2')  -- Doesn't print; a=b.

-- dofile is like require without caching:
dofile('mod2.lua')  --> Hi!
dofile('mod2.lua')  --> Hi! (runs it again)

-- loadfile loads a lua file but doesn't run it yet.
f = loadfile('mod2.lua')  -- Call f() to run it.

-- loadstring is loadfile for strings.
g = loadstring('print(343)')  -- Returns a function.
g()  -- Prints out 343; nothing printed before now.

--]]
