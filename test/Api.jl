module Api
export Interface, foo, bar

abstract type Interface end

function foo(i::Interface, s::String, n::Int)
    error("not implemented")
end

function bar(i::Interface, s::String, n::Int)
    error("not implemented")
end

end

