"""
    boxpass(X::PointSet, a, b)

Applies the box pass filter to boxes with corners `a, b` and `-a, -b`.
"""
boxpass(X::PointSet, a, b) = filter(X, RegionPassFilter(Box(makepoint(a),makepoint(b))))

"""
    centeredboxpass(X::PointSet, a)

Applies a centered box pass filter, i.e. a box with corners `-a, a`.
"""
centeredboxpass(X::PointSet, a) = filter(X, RegionPassFilter(CenteredBox(makepoint(a))))

(ir::ImpulseResponseRegion{D,T,CenteredBox{D,T}})(u::Real...) where {D,T} = ir(u)
function (ir::ImpulseResponseRegion{D,T,CenteredBox{D,T}})(u) where {D,T}
    b = ir.region
    C = prod(2b.l.coords)
    return C*prod(sinc(2b.l.coords[j]*u[j]) for j in 1:D)
end

function ImpulseResponseRegion(b::Box)
    l = Point((b.max.coords .- b.min.coords)./2)
    s =.-(b.min.coords .+ b.max.coords)./2
    return ImpulseResponseRegion(SymmShiftedRegion(CenteredBox(l), s))
end