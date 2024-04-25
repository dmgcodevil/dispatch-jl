module StaticDispatch
using Dispatch
include("Api.jl")
include("A.jl")
include("B.jl")

using .Api
using .ModuleA
using .ModuleB
import .Api: foo

@static_dispatch(Api.foo, [
    ModuleA.A,
    ModuleB.B,
])

function run()
    foo(A(), "a", 1)
    foo(B(), "b", 2)    
end
    
end
