module ModuleB

include("Api.jl")

using .Api

export Interface
export B, foo, bar

struct B <: Interface end

function foo(i::B, s::String, n::Int)
    println("B::echo(s=$s, n=$n)")
end

function bar(i::B, s::String, n::Int)
    println("B::bar(s=$s, n=$n)")
end

end