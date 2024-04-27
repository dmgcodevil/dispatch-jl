module ModuleA

include("Api.jl")

using .Api

export Interface
export A, foo, bar

struct A <: Interface end

function foo(i::A, s::String, n::Int)
    println("A::foo(s=$s, n=$n)")
end

function bar(i::A, s::String, n::Int)
    println("A::bar(s=$s, n=$n)")
end

end