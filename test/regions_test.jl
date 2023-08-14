@testset "regions" begin
    @testset "centered ball" begin
        c1 = CenteredBall{2}(3.0)
        c2 = CenteredBall{2}(2.0)
        @test c1 ∩ c2 == c2
        @test c2 ∩ c1 == c2
        @test c1 ∩ c2 isa CenteredBall
        c3 = Ball(Point(0.0,0.0),3)
    end
    @testset "centered box" begin
        c1 = CenteredBox(Point(1,2))
        c2 = CenteredBox(Point(1,1))
        @test c1 ∩ c2 == c2
        @test c2 ∩ c1 == c2
        @test c1 ∩ c2 isa CenteredBox
    end
end