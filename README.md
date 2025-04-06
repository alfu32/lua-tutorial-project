# Lua 5.4 Tutorial

## 🧠 Lua Curriculum for Advanced Developers

### **Module 1: Language Fundamentals (Complete Coverage)**

**Goal:** Build a full mental model of Lua’s semantics.

- **1.1 Syntax & Primitives**
    
    - Lexical structure
        
    - Dynamic typing, coercion rules
        
    - Numbers, strings, booleans, nil
        
- **1.2 Tables: The Core Data Structure**
    
    - Arrays, dictionaries
        
    - Metatables and metamethods
        
    - Deep/shallow copies, serialization patterns
        
- **1.3 Functions**
    
    - First-class functions
        
    - Closures and upvalues
        
    - Varargs and multiple return values
        
- **1.4 Control Flow**
    
    - Conditionals, loops
        
    - `goto`, labeled statements
        
    - Error handling: `pcall`, `xpcall`, and custom error strategies
        
- **1.5 Object-Oriented Patterns**
    
    - Manual prototypes
        
    - Class-like structures with metatables
        
    - Inheritance and composition
        
- **1.6 Modules & Scope**
    
    - `require`, package loader mechanism
        
    - Environment tables (`_ENV`)
        
    - Sandboxing patterns
        
- **1.7 Coroutines and Asynchrony**
    
    - `coroutine.create`, `yield`, `resume`
        
    - Producer/consumer, generator patterns
        
    - State machines
        
- **1.8 Luau & LuaJIT Differences (Optional)**
    
    - Extended features (e.g., type annotations in Luau)
        
    - Performance caveats and limitations
        

---

### **Module 2: Project Scaffolding & Tooling**

**Goal:** Establish clean, modular Lua project workflows.

- **2.1 File/Directory Structure Patterns**
    
    - `src/`, `lib/`, `test/`, `scripts/`, `bin/`
        
    - Versioning, vendoring, and layering
        
- **2.2 Interpreters**
    
    - Using `lua`, `luajit`, and `luau`
        
    - Managing multiple versions with Docker or asdf
        
- **2.3 Package Management**
    
    - Using [**luarocks**](https://luarocks.org/)
        
    - Declaring dependencies via `rockspec`
        
    - Local dev rocks vs global installations
        
    - Publishing packages
        
- **2.4 Build & Execution Automation**
    
    - Creating CLI scripts with entry points
        
    - Using Makefiles or shell scripts
        
    - Integrating with CI tools
        

---

### **Module 3: IDE & Editor Integration**

**Goal:** Efficient Lua development using modern IDEs.

- **3.1 Visual Studio Code
    - Extensions: Lua Language Server, Luacheck
    - Debugging with breakpoints and console
    - Linting, formatting, snippets
        
- **3.2 IntelliJ (via plugins)**
    - Using EmmyLua plugin
    - Code completion, documentation, unit testing
        
- **3.3 Luacheck & LDoc**
    - Static analysis
    - Documenting Lua codebases
        

---

### **Module 4: Testing & Maintenance**

**Goal:** Maintain robust, testable Lua code.

- **4.1 Unit Testing**
    
    - Using busted
        
    - Mocking and stubbing patterns
        
- **4.2 Benchmarking & Profiling**
    
    - Measuring performance
        
    - LuaJIT profiling tools
        
- **4.3 Code Quality**
    
    - Style guides
        
    - Dead code analysis
        
    - CI/CD integration for Lua
        

---

### **Module 5: Advanced Topics**

**Goal:** Deepen Lua mastery and apply in large-scale contexts.

- **5.1 Embedding & Interfacing**
    
    - Embedding Lua in C/C++/Rust
        
    - FFI and shared libraries
        
- **5.2 DSL Design with Lua**
    
    - Designing configuration and scripting interfaces
        
    - Declarative API patterns
        
- **5.3 Building Custom Interpreters**
    
    - Using Lua as a scripting engine for your apps
        

---

# **Module 0.1: Installing Lua & Scaffolding Your First Project**

### 🎯 Goals

- Install Lua (including LuaJIT + LuaRocks)
    
- Create a structured local Lua project
    
- Validate everything works with a “Hello, Lua” and utility module
    
- Prepare tooling for the rest of the course
    

---

## ✅ Step 1: Installing Lua, LuaJIT & Luarocks

### **Linux (Ubuntu/Debian)**


```bash
sudo apt update
sudo apt install lua5.4 luarocks
```

### **Optional: Install LuaJIT**


```bash
sudo apt install luajit
```

Check versions:

```bash
lua -v        # Lua 5.4.x
luajit -v     # LuaJIT 2.x luarocks --version`
```
---
## ✅ Step 2: Scaffolding the Project

Create a base project folder:

```bash
mkdir lua-tutorial-project && cd lua-tutorial-project  # recommended layout
mkdir -p src/lib
mkdir tests
touch main.lua
```

Basic structure:

```
lua-tutorial-project/
├── src/
│   └── lib/
│       └── utils.lua
├── tests/
├── main.lua
└── .luarc.json (later)`
```

---

## ✅ Step 3: Creating a Utility Module

**`src/lib/utils.lua`**

```lua
local utils = {} 

function utils.greet(name)
    return "Hello, " .. name .. "!"
end

return utils
```

---

## ✅ Step 4: Main Entry File

**`main.lua`**

```lua
package.path = "./src/?.lua;" .. package.path
local utils = require("lib.utils")
print(utils.greet("John"))
```

Run it:

```bash
lua main.lua
```

---

## ✅ Step 5: Initialize LuaRocks (optional but good)

Create a rockspec if you want dependency management:


```bash
luarocks init lua-tutorial-project 1.0-1 --lua-versions="5.4"`

```
Edit the generated `.rockspec` file to define source folders:


```lua
source = {
    url = "git://github.com/yourname/lua-tutorial-project"
}
build = {
    type = "builtin",
    modules = {
        ["lib.utils"] = "src/lib/utils.lua"
    }
}
```

---

## 🧪 Exercises & Examples

1. **Exercise 1:** Add a function `utils.add(a, b)` and test it in `main.lua`.
    
2. **Exercise 2:** Create a new module `lib.mathx` and export a factorial function.
    
3. **Exercise 3:** Use `lua -i` to open an interactive shell, manually require `lib.utils`, and call `greet`.
    
4. **Exercise 4:** Try replacing `lua` with `luajit` in your run commands — observe any differences.
    
5. **Exercise 5:** Write a simple shell script `run.sh` to run `main.lua` using LuaJIT.
    

---



# **Module 1.1: Lua Syntax & Primitives**

### 🎯 Goals

- Understand Lua's syntax rules
    
- Get comfortable with literals and types
    
- Explore dynamic typing and coercion
    
- Practice input/output and inline testing
    

---

## ✅ Key Concepts

### **1. Lua is minimal and clean**

- All statements end with **no semicolon** (they're optional)
    
- Blocks are defined by keywords (`do ... end`, `if ... end`, etc.)
    
- Functions, tables, and blocks are **first-class** citizens
    

---

### **2. Primitive Types**

|Type|Example|
|---|---|
|`nil`|`x = nil`|
|`boolean`|`true`, `false`|
|`number`|`3.14`, `-2`, `1e6`|
|`string`|`"hello"` or `'hi'`|
|`table`|`{}` (associative arrays)|
|`function`|`function() ... end`|
|`userdata`, `thread` – advanced topics||

---

### **3. String Literals**


```lua
local s1 = "double quoted"
local s2 = 'single quoted'
local s3 = [[
Multi-line
String
]]
```
                                        

### **4. Coercion & Dynamic Typing**

```lua
local n = "123"
print(tonumber(n) + 10)  --> 133
local b = 1
if b then 
    print("truthy")
end  --> prints`
```                                     

---

### **5. Input/Output**

```lua
print("Enter your name:")
local name = io.read()
print("Hello, " .. name)
```



---

## 🧪 Exercises & Examples

### **Exercise 1:** Print types of each primitive value

```lua
print(type(nil))
print(type(true))
print(type(42))
print(type("hi"))
print(type({}))
print(type(function() end))

```
                                        

### **Exercise 2:** Create a `describe(value)` function

Print whether a value is `truthy`, its type, and its string representation.

### **Exercise 3:** Parse a numeric string and multiply by 10

```lua
local input = "12.5"
print(tonumber(input) * 10)  --> 125.0`
```

### **Exercise 4:** Concatenate strings using `..` operator

```lua
local first = "Lua"
local second = "Rocks"
print(first .. " " .. second)
```
                                        

### **Exercise 5:** Accept input from the user and convert to uppercase


```lua
print("Enter text:")
local text = io.read()
print(string.upper(text))
```


---

# **Module 1.2: Tables – The Core Data Structure**

### 🎯 Goals

- Understand table creation and indexing
    
- Use tables as arrays and dictionaries
    
- Apply metatables for custom behavior
    
- Implement deep copying
    
- Prepare table utility functions for reuse
    

---

## 🧩 What Are Tables?

In Lua:

- Tables are **the only data structuring mechanism** (like arrays, dicts, objects).
    
- Tables are mutable, reference types.
    
- Functions, objects, and modules are implemented with tables.
    

---

## ✅ Syntax & Basics

```lua
local t = {}             -- empty table
t["name"] = "Paul"       -- string key
t.age = 42               -- sugar for t["age"]
t[1] = "first element"   -- numeric index (array-style)`
```
Tables can be declared inline:

```lua
local user = {
    name = "John",
    age = 30,
    skills = { "Lua", "C", "JS" }
}
```
                                        

---

## ✅ Arrays vs Dictionaries

Arrays (1-based indexing):

```lua
local fruits = { "apple", "banana", "cherry" }
print(fruits[2]) -- banana
```
Dictionaries:

```lua
local config = {
port = 8080,
host = "localhost"
}
```
                                        

Mixed tables:

```lua
local t = {
"index0", "index1",
foo = "bar",
[true] = "yes"
}
```

                                        

---

## ✅ Metatables & Metamethods

```lua
local a = { x = 1 }
local b = { y = 2 }
local mt = {
__add = function(lhs, rhs)
    return { x = lhs.x + (rhs.x or 0), y = lhs.y + (rhs.y or 0) }
  end
}
setmetatable(a, mt)
setmetatable(b, mt)
local c = a + b
print(c.x, c.y) -- 1, 2
```

                                        

Other metamethods: `__index`, `__newindex`, `__tostring`, `__eq`, etc.

---

## ✅ Deep Copy Example

```lua

function deepcopy(orig)
  local copy = {}
  for k, v in pairs(orig) do
      if type(v) == "table" then
        copy[k] = deepcopy(v)
      else
        copy[k] = v
      end
  end
  return copy
end
```

---

## ✅ Table Utilities

```lua
function table.len(t)
  local count = 0
  for _ in pairs(t) do
    count = count + 1
  end
  return count
end

function table.keys(t)
  local ks = {}
  for k in pairs(t) do
    table.insert(ks, k)
  end
  return ks
end
```
                                        

---

## 🧪 Exercises

1. **Exercise 1:** Create a table with mixed keys (string, number, boolean), iterate using `pairs`, print each key type.
    
2. **Exercise 2:** Write a metatable that enables two tables to be concatenated via `+`.
    
3. **Exercise 3:** Implement `table.map(t, fn)` that returns a new table where `fn(value)` was applied to each value.
    
4. **Exercise 4:** Write a table that acts like a default dictionary (returns `0` for missing keys).
    
5. **Exercise 5:** Write `table.to_string(t)` that recursively prints a table's structure (stringify deeply nested tables).
---

# **Module 1.3: Functions**

### 🎯 Goals

- Understand function declaration and expression styles
    
- Use closures and upvalues
    
- Use varargs and multiple return values
    
- Apply functional programming patterns
    

---

## ✅ Concepts

### 1. **Function Declarations**


```lua
function greet(name)
  return "Hello, " .. name
end
```
                                        

### 2. **Function Expressions**

```lua
local greet = function(name)
  return "Hello, " .. name
end
```
                                        

### 3. **Passing Functions**

```lua
function repeatAction(action, times)
  for i = 1, times do
    action(i)
  end
end
```
                                        

### 4. **Closures & Upvalues**

```lua
function counter()
  local count = 0
  return function()
    count = count + 1
    return count
  end
end                                                                                  local inc = counter()                                         

print(inc()) -- 1
print(inc()) -- 2
```
                                        

### 5. **Varargs and Multiple Return Values**

```lua
function printAll(...)
  local args = {...}
  for i, v in ipairs(args) do
    print(i, v)
  end
end

function divmod(a, b)
    return math.floor(a / b), a % b
end

local q, r = divmod(17, 5)
print(q, r) -- 3 2
```
                                        

---

## 📁 Add to Project

**`src/lib/funcs.lua`**

```lua
local funcs = {}
function funcs.counter()
  local count = 0
  return function()
    count = count + 1
    return count
  end
end

function funcs.map(fn, list)
  local results = {}
  for i, v in ipairs(list) do
    results[i] = fn(v)
  end
  return results
end
return funcs
```
                                        

**Use in `main.lua`**

```lua
local funcs = require("lib.funcs")
local c = funcs.counter()
print(c(), c(), c()) -- 1 2 3

local squared = funcs.map(function(x) return x * x end, {1,2,3})
for _, v in ipairs(squared) do
  print(v)
end
```
                                        

---

## 🧪 Exercises

1. **Create a function** `adder(n)` that returns a function which adds `n` to its argument.
    
2. **Make a logger function** that returns a closure logging a prefixed message:
    
```lua
local logInfo = logger("[INFO]")
logInfo("System ready.")
```
                                            
    
3. **Write a filter function** that takes a predicate and a list, returning only items that match.
    
4. **Wrap `divmod`** as a single return value:
    
```lua
function divmodWrap(a, b)
  local q, r = divmod(a, b)
  return {q = q, r = r}
end
```
                                            
    
5. **Build a pipeline function**:
    
```lua
function pipe(f1, f2)
  return function(x)
    return f2(f1(x))
  end
end
```

---

# **Module 1.4 – Control Flow**

### 🎯 Goals

- Use conditionals and branching
    
- Write loops with control statements
    
- Understand `goto` and labels
    
- Handle errors using `pcall`, `xpcall`, and `error`
    
- Build non-linear flows using `goto` responsibly
    

---

## 🧩 1. Conditionals

```lua
local x = 5
if x > 10 then
  print("Greater than 10")
elseif x > 3 then
  print("Greater than 3")
else
  print("3 or less")
end
```
                                        

- Lua treats `false` and `nil` as falsey; everything else (including `0` and `""`) is truthy.
    

---

## 🔁 2. Loops

### **Numeric `for`**

```lua
for i = 1, 5 do
  print("Count:", i)
end```
                                        

### **Generic `for`**

```lua
for k, v in pairs({a = 1, b = 2}) do
  print(k, v)
end
```
                                        

### **While loop**

```lua
local i = 1
while i <= 3 do
  print(i)
  i = i + 1
end
```
                                        

### **Repeat...until**

```lua
local x = 1
repeat
  print(x)
  x = x + 1
until x > 3
```
                                        

---

## ⛔ 3. `break` and `goto`

```lua
for i = 1, 10 do
  if i == 5 then
    break
  end
  print(i)
end
```
                                        

### **Using `goto`**

```lua
local i = 1
::start::
print("i is", i)
i = i + 1
if i <= 3 then
  goto start
end
```
                                        

---

## 🛠 4. Error Handling

### **Using `pcall`**

```lua
local ok, result = pcall(
  function()
    error("Something bad happened!")
  end
)
if not ok then
  print("Caught error:", result)
end
```
                                        

### **Using `xpcall`**

```lua
local function handler(err)
  return "Custom handler: " .. err
end
local ok, result = xpcall(
  function()
    error("Oops")
  end,
  handler
)
print(result)
```
                                        

---

## 🧪 Exercises

1. **Exercise 1:** Write a loop from 1 to 20, printing only even numbers using `if` and `continue` pattern (`goto`).
    
2. **Exercise 2:** Implement a simple retry mechanism using `pcall`, retrying a function 3 times if it fails.
    
3. **Exercise 3:** Re-implement `repeat...until` using `while` and `break`.
    
4. **Exercise 4:** Write a factorial function using a `for` loop with `break` if input is negative.
    
5. **Exercise 5:** Create a toy state machine with `goto` and labels for `idle`, `processing`, and `done` states.
    
---

# **Module 1.5 – Object-Oriented Patterns in Lua**

### 🎯 Goals

- Understand how to implement classes and instances manually
    
- Learn metatables for method resolution
    
- Use constructor functions and inheritance patterns
    
- Handle `self` idioms and method calls (`:` vs `.`)
    

---

## 🧱 Core Concepts

### ✅ 1. Tables as Objects

Everything is a table in Lua. "Objects" are just tables with methods.

```lua
local Dog = {}
Dog.__index = Dog
function Dog:new(name)
  local o = setmetatable({}, self)
  o.name = name
  return o
end
function Dog:speak()
  print(self.name .. " says woof!")
end
local myDog = Dog:new("Buddy")
myDog:speak() -- Buddy says woof!
```
                                        

### ✅ 2. `__index` and Inheritance

Inheritance is done by chaining `__index`:

```lua
local Animal = {}
Animal.__index = Animal
function Animal:new(name)
  return setmetatable({ name = name }, self)
end
function Animal:speak()
  print(self.name .. " makes a sound.")
end

local Dog = setmetatable({}, { __index = Animal })
Dog.__index = Dog
function Dog:speak()
  print(self.name .. " barks!")
end
local d = Dog:new("Fido")
d:speak() -- Fido barks!
```
                                        

### ✅ 3. The Colon `:` Sugar

`obj:method(args)` == `obj.method(obj, args)`

Always use `:` when defining object methods unless you're building static functions.

---

## 🧪 Exercises (Code-Based)

1. **Exercise 1:**  
    Create a `Person` class with `name`, `age`, and a `greet()` method.
    
2. **Exercise 2:**  
    Derive a `Student` class from `Person`. Add `studentID` and override `greet()` to include it.
    
3. **Exercise 3:**  
    Create a `Shape` base class and implement `Rectangle` and `Circle` subclasses. Add an `area()` method.
    
4. **Exercise 4:**  
    Simulate private fields by prefixing with `_`, and write a `getAge()` method that exposes it.
    
5. **Exercise 5:**  
    Write a utility function `class()` that creates a new class with optional inheritance:
    
```lua
local Dog = class("Dog", Animal)
```
                                            
    

---

## 🛠 Optional Tooling Tip

You can use libraries like [middleclass](https://github.com/kikito/middleclass) if you want more “typical” OOP behavior, but rolling your own helps you understand metatables and Lua’s flexibility.

---

# 🧩 **Module 1.6: Modules & Scope**

### 🎯 Goals

- Understand how `require`, `package.path`, and `module tables` work
    
- Learn how Lua's global and local scopes affect modularity
    
- Explore `_ENV` and sandboxing
    
- Build reusable, testable Lua modules
    

---

## 📚 Concepts

### 1. **Module Basics**

Lua doesn’t have built-in "modules"—instead, you define a table, populate it, and return it.

```lua
-- mymodule.lua
local M = {}
function M.sayHello()
  print("Hello from module!")
end
return M
```
                                        

Then use:

```lua
local mod = require("mymodule")
mod.sayHello()
```
                                        

---

### 2. **`package.path`**

Lua uses `package.path` to locate modules:

```lua
print(package.path)
-- Example: "./?.lua;./?/init.lua;/usr/share/lua/5.4/?.lua;..."
```
                                        

You can extend it in `main.lua`:

```lua
package.path = "./src/?.lua;" .. package.path`
```             

---

### 3. **Local vs Global Scope**

Avoid polluting the global scope!

```lua
-- BAD: global function
function greet()
  print("Hi")
end

-- GOOD: local scope
local function greet()
  print("Hi")
end
```
                                        

---

### 4. **The `_ENV` Table**

Used to sandbox or override global scope.

```lua
_ENV = { print = print, math = math } -- restrict scope
print(math.sqrt(16))  -- OK
-- print(os.date())
-- ERROR: os not in _ENV
```
                                        

Useful for sandboxing plugin code or untrusted scripts.

---

### 5. **Custom Module Loading**

You can override `require` to load encrypted files, remote content, etc.

```lua
table.insert(
  package.searchers, 1,
  function(name)
    if name == "custom" then
      return function()
        return { hello = function() print("Hi custom") end }
      end
    end
  end
)
```
                                        

---

## 🧪 Exercises & Examples

✅ **Exercise 1:** Create a module `lib.strings` with a function `reverse(s)` that reverses a string.
✅ **Exercise 2:** Add a new loader to `package.searchers` that returns a dummy module named `mock`.
✅ **Exercise 3:** Create `_ENV` in a file to restrict access to only `math` and `print`, then try using `os.date()`.
✅ **Exercise 4:** Write a module `lib.counter` with a private `count` variable (closure), and public `inc()` and `get()` functions.
✅ **Exercise 5:** Set `package.path` dynamically in `main.lua` to import from a `modules/` folder outside `src/`.

---

# **Module 1.7 – Coroutines and Asynchrony**

### 🎯 Goals

- Understand what coroutines are and how they differ from threads
    
- Learn how to create, resume, and yield coroutines
    
- Design asynchronous control flows
    
- Build real examples like producers/consumers or cooperative schedulers
    

---

## 🧠 Core Concepts

### What is a Coroutine?

Coroutines are resumable functions. You control when they pause (`yield`) and when they resume (`resume`).

```lua
coroutine.create(f)     -- creates a coroutine (suspended)
coroutine.resume(co)    -- starts or resumes a coroutine
coroutine.yield()       -- pauses execution
coroutine.status(co)    -- returns "suspended", "running", "dead"`
```

Unlike threads, coroutines run in the same thread and don’t preempt each other.

---

## ✍️ Examples & Exercises

### **Example 1: Basic Coroutine Lifecycle**

```lua
local co = coroutine.create(
  function()
    print("A")
    coroutine.yield()
    print("B")
  end
)
print(coroutine.status(co))  --> suspended
coroutine.resume(co)         --> prints A
print(coroutine.status(co))  --> suspended
coroutine.resume(co)         --> prints B
print(coroutine.status(co))  --> dead`
```                                        

> 📌 **Exercise:** Modify it to print A, B, C with two yields.

---

### **Example 2: Passing Values In and Out**

```lua
local co = coroutine.create(
  function(x)
    print("received:", x)
    local y = coroutine.yield(x + 1)
  print("resumed with:", y)
  return y * 2
  end
)

local status, val = coroutine.resume(co, 10)   --> received: 10
print("yielded:", val)
status, val = coroutine.resume(co, 5)          --> resumed with: 5
print("returned:", val)
```
                                        

> 📌 **Exercise:** Pass two arguments to the coroutine and perform arithmetic with both.

---

### **Example 3: Producer/Consumer Pattern**

```lua
function producer()
  return coroutine.create(
    function()
      for i = 1, 3 do
        coroutine.yield(i * 10)
      end
    end
  )
end

function consumer(prod)
  while coroutine.status(prod) ~= "dead" do
    local ok, val = coroutine.resume(prod)
    print("Consumed:", val)
  end
end
consumer(producer())
```
                                        

> 📌 **Exercise:** Extend this with random delays and simulate throttling.

---

### **Example 4: Coroutine-based Scheduler**

```lua
local function task(name, delay)
  return coroutine.create(
    function()
      for i = 1, 3 do
       print(name .. " step " .. i)
       coroutine.yield()
      end
    end
  )
end
local tasks = { task("A"), task("B") }
for i = 1, 6 do
local t = tasks[(i % 2) + 1]
coroutine.resume(t)
end
```
                                        

> 📌 **Exercise:** Make it round-robin any number of tasks.

---

### **Example 5: Building a Delay Simulator**

```lua
function wait(n)
for i = 1, n do
  coroutine.yield()
end
end
local co = coroutine.create(
  function()
    print("Start")
    wait(3)
    print("End")
  end
)
for _ = 1, 5 do
  coroutine.resume(co)
end
```
                                        

> 📌 **Exercise:** Integrate this into a fake game loop.

---

## 🧪 Bonus: Coroutine Utilities

Write a utility to "spawn" coroutines like tasks:

```lua
local function spawn(fn)
  local co = coroutine.create(fn)
  return function()
    coroutine.resume(co)
  end
end
local t1 = spawn(
  function()
    print("Running t1")
  end
)

t1()
```

---

# **Module 1.8: Luau & LuaJIT Differences (Optional)**

### 🎯 Goals

- Understand Luau’s extensions to standard Lua
    
- Learn what LuaJIT changes or optimizes
    
- Evaluate when to use each
    
- Spot compatibility concerns between environments
    

---

## 🧩 What is Luau?

> **Luau** is a **Roblox-specific dialect** of Lua 5.1 with type annotations, performance tweaks, and extended syntax.

- Based on **Lua 5.1**
    
- Supports **gradual typing**
    
- Extended syntax: type aliases, `continue`, `if let`, etc.
    
- No C API, runs **only in Roblox**
    

### 📘 Key Luau Features

|Feature|Luau Support|
|---|---|
|Type annotations|✅|
|`continue` in loops|✅|
|`typeof()` operator|✅|
|`table.freeze()`|✅|
|Destructuring assignment|✅|
|Built-in `assert(x: T?)`|✅|
|Enforced strict mode|✅ (opt-in)|

---

## ⚙️ What is LuaJIT?

> **LuaJIT** is a Just-In-Time compiled Lua interpreter based on Lua 5.1, designed for **speed**.

- Fully compatible with Lua 5.1
    
- **Extremely fast** (near C speed)
    
- Adds **FFI** for calling C libraries
    
- Often used in **games, real-time apps, embedded**
    

### 📘 Key LuaJIT Features

|Feature|LuaJIT Support|
|---|---|
|FFI (foreign function interface)|✅|
|JIT compilation|✅|
|`bit` library (before Lua 5.3)|✅|
|Interoperable with C|✅|
|Lua 5.2/5.3 compatibility|❌ (partial)|

---

## 🔥 Differences Summary

|Feature|LuaJIT|Luau|
|---|---|---|
|Target audience|Native devs|Roblox devs|
|Typing system|❌|✅ Gradual|
|Performance|⚡ Fast|🚀 Roblox-optimized|
|JIT Compilation|✅|❌|
|FFI|✅|❌|
|Built-in types|❌|✅ `Vector3`, `CFrame`|
|Language spec|Lua 5.1-ish|Lua 5.1-ish + extensions|
|Interoperability|✅ (C libs)|❌ Roblox-only|
|Runs outside Roblox|✅|❌|

---

## 🧪 Exercises & Examples

1. **Luau Only**: Write a typed function in Luau:

```lua
local function greet(name: string): string
  return "Hello, " .. name
end
```
                                            
    
2. **Luau Only**: Use `continue` in a loop:
    
```lua
for i = 1, 5 do
  if i == 3 then
    continue
  end
  print(i)
end
```
                                            
    
3. **LuaJIT Only**: Call a C function using FFI:
    
```lua
local ffi = require("ffi")
ffi.cdef[[
  int printf(const char *fmt, ...);
]]

ffi.C.printf("Hello from C!\n")`
```                                            
    
4. **Compare Performance**: Write a loop-heavy script and benchmark it in `lua` vs `luajit`.
    
5. **Compatibility Exercise**: Take a Roblox Luau script and try to run it in `lua`. Identify what fails and why.
    

---

# **Module 2: Project Scaffolding & Tooling**

### 🎯 Goals

- Understand idiomatic Lua project structures
    
- Automate builds and scripts
    
- Use Luarocks for dependencies
    
- Run Lua versions flexibly
    
- Prepare for clean CI-style development
    

---

## ✅ 2.1 File/Directory Structure Patterns

A **recommended directory structure**:

```
lua-tutorial-project/
├── src/              # All code lives here
│   └── lib/          # Submodules
├── tests/            # Unit tests
├── bin/              # CLI scripts
├── .luarc.json       # Language server config (for VS Code)
├── lua/              # Optional custom Lua scripts
├── run.sh            # Shortcut runner
├── main.lua          # Entry point
├── lua-tutorial-project-1.0-1.rockspec
└── README.md
```
                                        

Add this to `run.sh` to make executing easier:

```bash
#!/bin/bash
lua main.lua "$@"`
```                                        

Then:

```bash
chmod +x run.sh
./run.sh`
```                                        

---

## ✅ 2.2 Interpreters & Versions

### Install multiple Lua versions (with `asdf`)

```bash
asdf plugin-add lua https://github.com/Stratus3D/asdf-lua.git
asdf install lua 5.4.6
asdf global lua 5.4.6
```
                                        

### For LuaJIT:

```bash
sudo apt install luajit
```
                                        

Now you can test code like this:

```bash
luajit main.lua
lua main.lua
```
                                        

---

## ✅ 2.3 Package Management with Luarocks

### Install dependencies locally

```bash
luarocks install lua-cjson
```
                                        

Use it in code:

```lua
local cjson = require("cjson")
print(cjson.encode({foo = "bar"}))
```
                                        

Declare dependencies in your rockspec:

```lua
dependencies = {
  "lua >= 5.4",
  "lua-cjson"
}
```

To generate `.rockspec`:

```bash
luarocks init myproject 1.0-1 --lua-versions="5.4"`
```                                        

---

## ✅ 2.4 Build & Execution Automation

Create a `Makefile`:

```Makefile
.PHONY: run test lint clean
run:
    lua main.lua
test:
    busted tests/
lint:
    luacheck src/
clean:
    rm -rf *.rock* *.lua~ *.bak`
```
Run:

```bash
make run
```
                                        

---

## 🧪 Exercises & Examples

1. **Exercise 1:** Create a new script in `bin/hello.lua` that prints CLI args. Run it via `lua bin/hello.lua arg1`.
    
2. **Exercise 2:** Add a dependency like `Penlight` (`luarocks install penlight`) and use `pl.pretty.dump()`.
    
3. **Exercise 3:** Create and install your own local rock:
    
```bash
luarocks make
```
                                            
    
4. **Exercise 4:** Write a `Makefile` rule to install all dependencies.
    
5. **Exercise 5:** Create a Dockerfile that installs Lua 5.4, luarocks, and runs `main.lua`.
    
---

# **Module 3: IDE & Editor Integration**

### 🎯 Goals

- Get productive using **VS Code** or **IntelliJ** with **Lua Language Server**
    
- Enable linting, type hints, and debugging
    
- Add support for code formatting and static analysis
    
- Explore IntelliJ Lua support via EmmyLua
    
- Prep environment for large project workflows
    

---

## 🧰 Tooling Summary

|Feature|Tool|Notes|
|---|---|---|
|Language Server|`lua-language-server`|Fast, feature-rich LSP|
|Linting|`luacheck`|Detects unused vars, shadowing, globals|
|Docs|`ldoc`|Lua docgen|
|Debugging|VSCode Lua Debugger|For step-through and breakpoints|
|IntelliJ|EmmyLua Plugin|Best IntelliJ Lua support (not official)|

---

## ✅ 3.1: Setup with Visual Studio Code

### a) Install VS Code Extensions

1. **Lua Language Server** – [Sumneko Lua](https://github.com/LuaLS/luals)
    
2. **Lua Debug** – if you want breakpoints
    
3. **Lua Formatter** – optional for style
    

### b) Setup `.luarc.json`

Place in project root:

```json
{
  "runtime": {
    "version": "Lua 5.4",
    "path": ["src/?.lua", "src/?/init.lua"]
  },
  "workspace": {
    "library": ["./src"]
  },
  "diagnostics": {
    "globals": ["vim"]
  }
}
```
                                        

> Adjust `globals` for your environment (e.g., `love`, `vim`, `game`, etc.)

---

## ✅ 3.2: Luacheck for Linting

### Install:

```bash
luarocks install luacheck
```
                                        

Create `.luacheckrc` in project root:

```lua
files = { "src", "tests", "main.lua" }
globals = {
  "describe", "it", "before_each", "after_each"  -- for busted
}
unused_args = false`
```                                        

Run it:

```bash
luacheck .
```
                                        

---

## ✅ 3.3: Lua Debugger in VS Code

In `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Debug Lua",
      "type": "lua",
      "request": "launch",
      "program": "${workspaceFolder}/main.lua"
    }
  ]
}
```
                                        

> You'll need the VSCode extension that supports Lua debug (or use `mobdebug` if working with ZeroBrane-style remote debugging).

---

## ✅ 3.4: IntelliJ + EmmyLua

1. Install **[EmmyLua plugin](https://plugins.jetbrains.com/plugin/9768-emmylua)**.
    
2. Configure SDK as system Lua (`/usr/bin/lua`)
    
3. Enable annotations like:
    

```lua
---@param name string
---@return string
function greet(name)
  return "Hello, " .. name
end
```
                                        

> EmmyLua parses these and provides IntelliSense + static checking.

---

## ✅ 3.5: Optional – LDoc for Documentation

Install:

```bash
luarocks install ldoc
```
                                        

Add a doc comment in `utils.lua`:

```lua
--- Say hello to someone
-- @param name string The name to greet
-- @return string A greeting message
function utils.greet(name)
  return "Hello, " .. name
end
```
                                        

Generate docs:

```bash
ldoc src
```
                                        

---

## 🧪 Exercises

1. **Exercise 1:** Add `.luarc.json` to your project and verify that auto-complete and path resolution work in VS Code.
    
2. **Exercise 2:** Annotate 3 functions with EmmyLua-style comments and check IntelliSense.
    
3. **Exercise 3:** Trigger and fix 3 lint warnings using `luacheck`.
    
4. **Exercise 4:** Set a breakpoint in `main.lua` and step into a utility function.
    
5. **Exercise 5:** Generate HTML documentation using `ldoc`, and open the generated file in a browser.
  

---

# **Module 4: Testing & Maintenance**

### 🎯 Goals

- Set up and use a test framework (`busted`)
    
- Write unit and integration tests
    
- Benchmark performance
    
- Maintain code quality with static analysis (`luacheck`)
    
- Integrate all into a maintainable workflow
    

---

## ✅ Step 1: Install Testing & QA Tools

Install **busted** and [**luacheck**](https://github.com/mpeterv/luacheck):

```bash
luarocks install busted
luarocks install luacheck
```
                                        

---

## ✅ Step 2: Write Unit Tests with Busted

### **Folder structure** (if not already created):

```css
lua-tutorial-project/
├── src/
│   └── lib/
│       └── utils.lua
├── tests/
│   └── test_utils.lua
```
                                        

### **Example: tests/test_utils.lua**

```lua
local utils = require("lib.utils")
describe(
  "utils.greet",
  function()
    it(
      "returns a proper greeting",
      function()
        assert.is_equal(utils.greet("Paul"), "Hello, Paul!")
      end
    )
  end
)
```
                                        

Run:

```bash
busted tests/
```
                                        

---

## ✅ Step 3: Benchmarking

### **Manual Benchmark**

```lua
local socket = require("socket")
local t0 = socket.gettime()
for i = 1, 1e6 do
  local x = i * 2
end
local t1 = socket.gettime()
print("Elapsed: " .. (t1 - t0) .. " seconds")
```

You can also try `lua-benchmark`, `busted` has built-in `performance` assertions too.

---

## ✅ Step 4: Static Analysis with Luacheck

Create a config file: **`.luacheckrc`**

```lua
files = {
  "**.lua"
}
globals = {
  "describe", "it", "assert" -- busted globals
}
```
                                        

Run:

```bash
luacheck .
```

---

## ✅ Step 5: Automate with a Makefile

**Makefile**

```make
test:
    busted tests
lint:
    luacheck .
bench:
    lua benchmarks/mymodule.lua
```
                                        

Then:

```bash
make test
make lint
```
                                        

---

## 🧪 Exercises

1. **Exercise 1:** Add a new test for `utils.add(a, b)` ensuring it handles negative numbers.
    
2. **Exercise 2:** Write a test that fails and verify busted output.
    
3. **Exercise 3:** Create a `benchmarks/` folder and benchmark recursive vs iterative factorial.
    
4. **Exercise 4:** Use Luacheck to fix a warning in one of your modules.
    
5. **Exercise 5:** Add a new Makefile target `qa:` that runs both `test` and `lint`.

---

# **Module 5: Advanced Topics**

---

## 🔹 **5.1 Embedding & Interfacing**

### 🔧 Goal:

Run Lua **inside C/C++/Rust apps**, and call native code from Lua.

### 🔍 Concepts:

- Linking Lua runtime into host applications
    
- Calling Lua from C/C++
    
- Calling C/C++ from Lua via LuaJIT FFI or manual bindings
    

### 💡 Example:

**C code embedding Lua:**

```c
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>
int main() {
  lua_State* L = luaL_newstate();
  luaL_openlibs(L);
  luaL_dostring(L, "print('Hello from Lua inside C!')");
  lua_close(L);
  return 0;
}
```
                                        

---

## 🔹 **5.2 Foreign Function Interface (FFI)**

### 🔧 Goal:

Use **LuaJIT FFI** to call C libraries directly from Lua.

### 🔍 Concepts:

- Defining C declarations using `ffi.cdef`
    
- Loading shared libraries with `ffi.load`
    
- Direct memory manipulation
    

### 💡 Example:

```lua
local ffi = require("ffi")
ffi.cdef[[
  int printf(const char *fmt, ...);
]]

ffi.C.printf("Hello from LuaJIT FFI!\n")
```
---

## 🔹 **5.3 DSL Design with Lua**

### 🔧 Goal:

Use Lua as a **domain-specific language engine**.

### 🔍 Concepts:

- Declarative APIs
    
- Metatables for DSL constructs
    
- Table-as-code strategies
    

### 💡 Example (Mini config DSL):

```lua
config = {
  window = { width = 800, height = 600 },
  title = "My Game"
}
print(config.window.width)`
```                                        

Or dynamically:

```lua
function define(cfg)
  return cfg
end

local game = define {
  name = "LuaRunner",
  players = 2
}
```
                                        

---

## 🔹 **5.4 Custom Interpreters / Sandboxing**

### 🔧 Goal:

Create **sandboxed or modified Lua runtimes**.

### 🔍 Concepts:

- Custom `_ENV` environments
    
- Controlling available globals
    
- Sandboxed `load()` and `loadstring()` execution
    

### 💡 Example:

```lua
local sandbox_env = {
  print = print,
  math = math
}
local code = "return math.sqrt(16)"
local fn = load(code, "sandbox", "t", sandbox_env)
print(fn())  --> 4
```
                                        

---

## 🔹 **5.5 Building REPLs or Command Interpreters**

### 🔧 Goal:

Create your own **interactive Lua shell** or a custom command DSL.

### 🔍 Concepts:

- Reading user input
    
- Evaluating Lua safely
    
- Command routing using metatables or dispatch tables
    

### 💡 Example:

```lua
while true do
  io.write("> ")
  local line = io.read()
  local fn = load("return " .. line)
  if fn then
    print(fn())
  end
end
```
                                        

---

## 🧪 Exercises

1. **Write a C/C++ program** that executes Lua code to generate a value and pass it back.
    
2. **Use LuaJIT FFI** to bind a shared C library (e.g., zlib or your own `.so`).
    
3. **Write a DSL** to declare UI layout using only tables and metatables.
    
4. **Sandbox a Lua script** to restrict access to I/O and `os` functions.
    
5. **Build a mini REPL** that supports variable definitions and math operations with error handling.
    
---

# **Module 6: Advanced Application Programming in Lua**

---

## 🔹 **6.1 Idiomatic Lua Patterns**

### 💡 Goals:

Learn idiomatic data manipulation and functional constructs in Lua.

#### ✅ Topics:

- Using **tables as hashmaps** and arrays
    
- Emulating **map, reduce, filter**
    
- `indexBy`, `groupBy`, and other utility patterns
    
- `for`, `ipairs`, `pairs`, `next` idioms
    

#### 💡 Example:

```lua
function map(tbl, fn)
  local out = {}
  for i, v in ipairs(tbl) do
    out[i] = fn(v)
  end
  return out
end
```
                                        

---

## 🔹 **6.2 Standard Libraries**

### 💡 Goals:

Use Lua’s built-in libraries effectively.

#### ✅ Topics:

- `string`, `math`, `table`, `os`, `coroutine`, `debug`
    
- `load`, `require`, `dofile`, `module` (legacy)
    
- Pattern matching (not full regex)
    

#### 💡 Example:

```lua
print(string.match("abc123", "%d+"))  --> 123
```
                                        

---

## 🔹 **6.3 Systems Programming**

### 🔧 6.3.1 File I/O and Streams

- `io.open`, `io.read`, `io.write`, `io.lines`
    
- Reading binary files
    
- Line-by-line processing
    

### 💡 Example:

```lua
for line in io.lines("file.txt") do
  print(line)
end
```
                                        

---

### 🔧 6.3.2 Data Formats

- **JSON:** Use `dkjson`, `cjson`, or `lunajson`
    
- **CSV:** Use `lua-csv` or parse manually
    
- **XML:** `LuaExpat`, `LuaXML`
    
- **YAML:** `lyaml`, `yaml.lua`
    

```lua
local json = require("dkjson")
local data = json.decode('{"x": 1}')
```
                                        

---

### 🔧 6.3.3 HTTP Clients & Servers

- **HTTP clients:** `socket.http`, `lua-http`, `http.request` (LuaSocket)
    
- **Servers:** `copas`, `lua-http`, `luv`
    

```lua
local http = require("socket.http")
local body = http.request("https://example.com")
```
                                        

---

### 🔧 6.3.4 Databases

- **SQLite:** `lsqlite3`
    
- **Postgres:** `luapgsql`
    
- **MySQL:** `luasql.mysql`, `luamysql`
    
- **Oracle:** limited, via C FFI or ODBC
    

```lua
local sqlite3 = require("lsqlite3")
local db = sqlite3.open("test.db")
```
                                        

---

## 🔹 **6.4 Graphical and Terminal Interfaces**

### 🔧 6.4.1 Frameworks and Bindings

- **SDL**, **OpenGL**, **Dear ImGui** via FFI
    
- Love2D (game dev with graphics)
    

### 🔧 6.4.2 GUI Frameworks

- **IUP** – multi-platform UI
    
- **wxLua** – bindings to wxWidgets
    
- **LÖVE (Love2D)** – game + UI toolkit
    

```lua
-- Love2D GUI app layout
function love.draw()
  love.graphics.print("Hello, GUI", 100, 100)
end
```
                                        

### 🔧 6.4.3 TUI Frameworks

- `lcurses` – terminal-based UIs
    
- `blessed` and `curses` via FFI or LuaRocks
    

---

## 🔹 **6.5 Package Repositories**

### 💡 LuaRocks: The standard package manager

- Install with `sudo apt install luarocks`
    
- Find packages at [https://luarocks.org](https://luarocks.org)
    
- Create `.rockspec` files for publishing
    

```bash
luarocks install luafilesystem
```
                                        

---

## 🧪 Exercises (5 from Module 6)

1. **Write map/filter/reduce functions** using `table` in idiomatic Lua style.
    
2. **Parse a JSON file**, modify it, and write it back.
    
3. **Create a simple HTTP downloader** using LuaSocket or LuaHTTP.
    
4. **Write a SQLite-backed task tracker** CLI app.
    
5. **Build a TUI app** that shows CPU and memory stats using `lcurses`.
