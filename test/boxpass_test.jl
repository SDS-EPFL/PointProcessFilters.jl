@testset "boxpass" begin
    X = PointSet(Point.(rand(10), rand(10)))
    @test_throws ErrorException boxpass(X, (-0.1,-0.1), (1,0.2))
    Y = boxpass(X, (0.1,0.1), (1,0.2))
    Y2 = boxpass(X, (-1,-0.2), (-0.1,-0.1))
    Z = centeredboxpass(X, (1,1))
    @test Y((1.0,0.0)) isa Float64
    @test Y((1.0,0.0)) == Y2(1.0,0.0)
    @test Z(1,1) isa Float64
end