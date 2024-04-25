module DynamicDispatch
using Dispatch
include("Api.jl")
include("A.jl")
include("B.jl")

using .Api
using .ModuleA
using .ModuleB
import .Api: foo

@dynamic_dispatch(Main.DynamicDispatch.Api.foo)

function run()
    foo(A(), "a", 1)
    foo(B(), "b", 2)
end

end
