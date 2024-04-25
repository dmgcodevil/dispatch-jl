module Api
export Interface, foo

abstract type Interface end

function foo(i::Interface, s::String, n::Int)
    error("not implemented")
end

end

