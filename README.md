# dispatch-jl
Dispatch.jl is a Julia package that provides macros for dynamic and static dispatch of function calls based on the types of the input arguments. This can be useful in scenarios where multiple modules define functions with the same names, and the appropriate function needs to be called based on the types of input arguments.

# Example

[Tests](https://github.com/dmgcodevil/dispatch-jl/tree/main/test)

Imagine you have `Api` module and two implementation modules: `ModuleA` and `ModuleB`

Api:

```jl
module Api
export Interface, foo

abstract type Interface end

function foo(i::Interface, s::String, n::Int)
    error("not implemented")
end

end
```

ModuleA:

```
module ModuleA

include("Api.jl")

using .Api

export Interface
export A, foo

struct A <: Interface end

function foo(i::A, s::String, n::Int)
    println("A::echo(s=$s, n=$n)")
end

end
```

ModuleB:

```jl
module ModuleB

include("Api.jl")

using .Api

export Interface
export B, foo

struct B <: Interface end

function foo(i::B, s::String, n::Int)
    println("B::echo(s=$s, n=$n)")
end

end
```

Dispatch.jl provides two macros:

#### @dynamic_dispatch

The `@dynamic_dispatch` macro dynamically dispatches function calls based on the type of the first argument. Here's how to use it:

```jl
using Dispatch
include("Api.jl")
include("A.jl")
include("B.jl")

using .Api
using .ModuleA
using .ModuleB
import .Api: foo

@dynamic_dispatch(Main.Api.foo)

foo(A(), "a", 1)
foo(B(), "b", 2)    
```

the macro will generate a code like the below:

```jl
begin
    function foo(i, s, n)
        var"#6#obj" = i
        var"#7#m" = Dispatch.parentmodule(Dispatch.typeof(var"#6#obj"))   
        return (var"#7#m").foo(i, s, n)
    end
end
```

#### @static_dispatch

The `@static_dispatch` macro generates specialized methods for a given function and a list of argument types. Here's how to use it:

```jl
using Dispatch
include("Api.jl")
include("A.jl")
include("B.jl")

using .Api
using .ModuleA
using .ModuleB
import .Api: foo

@static_dispatch(Main.Api.foo, [
    Main.ModuleA.A,
    Main.ModuleB.B,
])

# or relative path
# @static_dispatch(Api.foo, [
#     ModuleA.A,
#     ModuleB.B,
# ])

foo(A(), "a", 1)
foo(B(), "b", 2)   
    
```

the macro will generate methods for `A` and `B`, i.e.:

```jl
function foo(i::A, s::String, n::Int)
    ModuleA.foo(i, s, n)
end

function foo(i::B, s::String, n::Int)
    ModuleB.foo(i, s, n)
end
```

### Choosing Between `@dynamic_dispatch` and `@static_dispatch`

Use `@dynamic_dispatch` during development: When exploring different implementations or when the set of argument types may change during development, `@dynamic_dispatch` provides flexibility and ease of use.
Consider switching to `@static_dispatch` for production: Once the set of argument types is stable and performance becomes a concern, consider switching to `@static_dispatch` to minimize dispatch overhead and improve performance.




