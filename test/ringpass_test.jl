@testset "ringpass" begin
    X = PointSet(Point.(rand(10), rand(10)))
    @test_throws AssertionError ringpass(X, -1, 1)
    @test_throws AssertionError ringpass(X, 1, 0.1)
    Y = ringpass(X, 0, 1)
    @test Y((1.0,0.0)) isa Float64
    @test Y(1.0,0.0) == Y((1.0,0.0))
end