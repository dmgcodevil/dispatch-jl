module DynamicDispatch
using Dispatch
include("Api.jl")
include("A.jl")
include("B.jl")

using .Api
using .ModuleA
using .ModuleB
import .Api: foo, bar

@dynamic_dispatch(Api.foo) # relative
@dynamic_dispatch(Main.DynamicDispatch.Api.bar)  # absolute

function run()
    foo(A(), "a", 1)
    foo(B(), "b", 2)
    bar(A(), "a", 3)
    bar(B(), "b", 4)
end

end
