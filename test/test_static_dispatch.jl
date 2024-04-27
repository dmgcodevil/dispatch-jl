module StaticDispatch
using Dispatch
include("Api.jl")
include("A.jl")
include("B.jl")

using .Api
using .ModuleA
using .ModuleB
import .Api: foo

# relative
@static_dispatch(Api.foo, [
    ModuleA.A,
    ModuleB.B,
])

# absolute
@static_dispatch(Main.StaticDispatch.Api.bar, [
    Main.StaticDispatch.ModuleA.A,
    Main.StaticDispatch.ModuleB.B,
])

function run()
    foo(A(), "a", 1)
    foo(B(), "b", 2)
    bar(A(), "a", 3)
    bar(B(), "b", 4)
end
    
end
