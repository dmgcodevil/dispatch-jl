module Dispatch

export @dynamic_dispatch, @static_dispatch

macro dynamic_dispatch(fun)
    args = Base.method_argnames(methods(eval(fun))[1])[2:end]
    name = collect(eachsplit(string(eval(fun)), "."))[end]
    body = quote
        function $(esc(Symbol(name)))($(map(esc, args)...))
            obj = $(args[1])
            m = parentmodule(typeof(obj))
            return m.$(Symbol(name))($(map(esc, args)...))
        end
    end
    return body
end

macro static_dispatch(fun, types)
    name = collect(eachsplit(string(eval(fun)), "."))[end]
    method = methods(eval(fun))[1]
    # args_types = method.sig.parameters[2:end]
    args_names = Base.method_argnames(method)[2:end]
    module_types = [(parentmodule(t), t) for t in eval(types)]
    specialized_functions = [
        :(
            function $(esc(Symbol(name)))(i::$t, $(args_names[2:end]...))
                $m.$(Symbol(name))(i, $(args_names[2:end]...))
            end
        )
        for (m, t) in module_types
    ]
    body = quote
        $(specialized_functions...)
    end
    return body
end

end