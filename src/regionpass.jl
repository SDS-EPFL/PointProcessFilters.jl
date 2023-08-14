abstract type SpatialFilter{D} end
struct RegionPassFilter{D,T,R<:Geometry{D,T}} <: SpatialFilter{D} 
    region::R
end

struct ImpulseResponseRegion{D,T,R<:Geometry{D,T},P}
    region::R
    precomp::P
    function ImpulseResponseRegion(r::Geometry{D,T}) where {D,T}
        check_region_condition(r)
        p = impulseresponse_precomp(r)
        new{D,T,typeof(r),typeof(p)}(r, p)
    end
end


"""
    check_region_condition(::Geometry)

Perform additional checks on the provided region.
"""
check_region_condition(::Geometry) = nothing

"""
    impulseresponse_precomp(::Geometry)

Generates precomputed quantities for a given region.
"""
impulseresponse_precomp(::Geometry) = nothing
struct FilteredProcess{D,T,I}
    points::PointSet{D,T}
    ir::I
end

"""
    filter(X::PointSet{D,T}, r::SpatialFilter{D}) where {D,T}

Applies a given spatial filter `r` to a point set.
The output can be evaluated as a function.

# Example
```julia
r = 1.0
X = PointSet(Point.(rand(10), rand(10)))
Y = filter(X, r)
Y(1.0,1.0)
u = (1.0,1.0)
Y(u)
```
"""
function filter(X::PointSet{D,T}, r::SpatialFilter{D}) where {D,T}
    h = impulse_response(r)
    return FilteredProcess(X,h)
end
(f::FilteredProcess)(u::Real...) = f(u)
(f::FilteredProcess{D,T,I})(u::Meshes.Vec{D,<:Real}) where {D,T,I} = f(u.coords)
function (f::FilteredProcess{D,T,I})(u::NTuple{D,Real}) where {D,T,I}
    pts = f.points.geoms
    out = f.ir(u.-first(pts).coords.coords)
    for i in firstindex(pts)+1:lastindex(pts)
        out+=f.ir(u.-pts[i].coords.coords)
    end
    return out
end

"""
    impulse_response(r::RegionPassFilter)

Computes the impulse response function for a region pass filter.
Result is of type ImpulseResponseRegion, a callable struct.
"""
impulse_response(r::RegionPassFilter) = ImpulseResponseRegion(r.region)

impulseresponse_precomp(r::MinusGeom) = (h1=impulse_response(RegionPassFilter(r.a)), h2=impulse_response(RegionPassFilter(r.b ∩ r.a)))
(ir::ImpulseResponseRegion{D,T,<:MinusGeom})(u::Real...) where {D,T} = ir(u)
function (ir::ImpulseResponseRegion{D,T,<:MinusGeom})(u) where {D,T}
    return ir.precomp.h1(u) - ir.precomp.h2(u)
end

function impulseresponse_precomp(r::UnionGeom)
    hb = impulse_response(RegionPassFilter(r.b))
    ha = impulse_response(RegionPassFilter(r.a))
    hb_cap_a = if r.b ∪ r.a === nothing
        return nothing
    else
        return impulse_response(RegionPassFilter(r.b ∩ r.a))
    end
    return (ha=ha, hb=hb, hb_cap_a=hb_cap_a)
end
(ir::ImpulseResponseRegion{D,T,<:UnionGeom})(u::Real...) where {D,T} = ir(u)
function (ir::ImpulseResponseRegion{D,T,<:UnionGeom})(u) where {D,T}
    ha=ir.precomp.ha; hb=ir.precomp.hb; hb_cap_a=ir.precomp.hb_cap_a
    if hb_cap_a === nothing
        return hb(u) + ha(u)
    else
        return hb(u) + ha(u) - hb_cap_a(u)
    end
end

function check_region_condition(r::SymmShiftedRegion{D,T,R}) where {D,T,R}
    if Point(zero(Vec{D,T})) ∈ shift(r.region, r.shift)
        error("Not yet implemented for shifts which dont exclude zero from the region. Requires overlap.")
    end
    nothing
end
impulseresponse_precomp(r::SymmShiftedRegion) = (hr=ImpulseResponseRegion(r.region),shift=r.shift)
(ir::ImpulseResponseRegion{D,T,<:SymmShiftedRegion})(u::Real...) where {D,T} = ir(u)
function (ir::ImpulseResponseRegion{D,T,<:SymmShiftedRegion})(u) where {D,T}
    return ir.precomp.hr(u) * 2cos(2π * sum(ir.precomp.shift .* u))
end