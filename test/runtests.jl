using PointProcessFilters
using Test
import PointProcessFilters: Point, PointSet, Box, Ball, CenteredBall, CenteredBox

@testset "PointProcessFilters.jl" begin
    include("regions_test.jl")
    include("ringpass_test.jl")
    include("boxpass_test.jl")
    include("circlepass_test.jl")
end
