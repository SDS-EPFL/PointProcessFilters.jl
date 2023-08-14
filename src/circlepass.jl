"""
    circlepass(X::PointSet, p, r)

Applies a circle pass filter with circles centered at `p` and `-p` in wavenumber and radii of `r`.
"""
circlepass(X::PointSet, p, r) = filter(X, RegionPassFilter(Ball(makepoint(p),r)))

"""
    centeredcirclepass(X::PointSet{D,T}, r) where {D,T}

Applies a circle pass filter centered at zero, with radius `r`.
"""
centeredcirclepass(X::PointSet{D,T}, r) where {D,T} = filter(X, RegionPassFilter(CenteredBall{D}(r)))

"""
    ringpass(X::PointSet{D,T}, a, b) where {D,T}

Applies a ring pass (annulus) filter with the inner radius `a` and outer radius `b`.
"""
function ringpass(X::PointSet{D,T}, a, b) where {D,T}
    @assert 0 ≤ a < b
    if a == 0
        @warn "a is 0, better to use centeredcirclepass in this case."
    end
    filter(X, RegionPassFilter(CenteredBall{D}(b)-CenteredBall{D}(a)))
end
(ir::ImpulseResponseRegion{D,T,CenteredBall{D,T,R}})(u::Real...) where {D,T,R} = ir(u)
function (ir::ImpulseResponseRegion{D,T,CenteredBall{D,T,R}})(u) where {D,T,R}
    b = ir.region
    r = b.radius
    x = norm(u)
    if D===1
        return 2r*sinc(2r*x)
    elseif D===2
        return (r/x) * besselj1(2π*r*x)
    else
        return (r/x)^(D/2) * besselj(D/2, 2π*r*x)
    end
end

function ImpulseResponseRegion(b::Ball{D,T}) where {D,T}
    ImpulseResponseRegion(SymmShiftedRegion(CenteredBall{D}(b.radius), b.center.coords))
end