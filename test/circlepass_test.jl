@testset "circlepass" begin
    X = PointSet(Point.(rand(10), rand(10)))
    @test_throws ErrorException circlepass(X, (0,0), 1.0)
    Y = circlepass(X, (1,2),1)
    Z = centeredcirclepass(X, 1.0)
    @test Z((1.0,0.0)) isa Float64
    @test Z(1.0,0.0) == Z((1.0,0.0))
    @test Y(1.0,0.0) isa Float64
end