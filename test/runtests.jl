using Dispatch
using Test

include("test_dynamic_dispatch.jl")
include("test_static_dispatch.jl")

import .DynamicDispatch
import .StaticDispatch

@test true == true  # Example test

@testset "dynamic_dispatch" begin
    DynamicDispatch.run()
end

@testset "static_dispatch" begin
    StaticDispatch.run()
end