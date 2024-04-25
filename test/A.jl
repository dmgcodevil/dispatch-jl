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