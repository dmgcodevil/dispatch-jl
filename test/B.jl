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