struct UnionGeom{D,T,G1<:Geometry{D,T},G2<:Geometry{D,T}} <: Meshes.Geometry{D,T}
    a::G1
    b::G2
end
struct MinusGeom{D,T,G1<:Geometry{D,T},G2<:Geometry{D,T}} <: Meshes.Geometry{D,T}
    a::G1
    b::G2
end
Base.union(a::Geometry{D,T}, b::Geometry{D,T}) where {D,T} = UnionGeom(a,b)
Base.:-(a::Geometry{D,T}, b::Geometry{D,T}) where {D,T} = MinusGeom(a,b)

struct SymmShiftedRegion{D,T,R<:Geometry{D,T}} <: Meshes.Geometry{D,T}
    region::R
    shift::Vec{D,T}
end

struct CenteredBox{D,T} <: Meshes.Geometry{D,T}
    l::Point{D,T}
    function CenteredBox(l::Point{D,T}) where {D,T}
        @assert all(l.coords.>0)
        new{D,T}(l)
    end
end
struct CenteredBall{D,T,R<:Real} <: Meshes.Geometry{D,T}
    radius::R
    function CenteredBall{D}(r::T) where {D,T}
        @assert r ≥ 0
        new{D,T,typeof(r)}(r)
    end
end

minimum(c::CenteredBox) = Point(.-c.l.coords)
maximum(c::CenteredBox) = c.l

Base.intersect(a::CenteredBall{D,T,R},b::Geometry) where {D,T,R} = intersect(Ball(Point(zero(Vec{D,T})), a.radius), b)
Base.intersect(a::Geometry,b::CenteredBall{D,T,R}) where {D,T,R} = intersect(a, Ball(Point(zero(Vec{D,T})), b.radius))
function Base.intersect(a::CenteredBall{D,T,R},b::CenteredBall{D,S}) where {D,T,R,S}
    CenteredBall{D}(min(a.radius, b.radius))
end

Base.intersect(a::CenteredBox{D,T},b::Geometry) where {D,T} = intersect(Box(minimum(a),maximum(a)), b)
Base.intersect(a::Geometry,b::CenteredBox{D,T}) where {D,T} = intersect(a, Box(minimum(b), maximum(b)))
function Base.intersect(a::CenteredBox{D,T},b::CenteredBox{D,S}) where {D,T,S}
    CenteredBox(Point(min.(a.l.coords, b.l.coords)))
end

shift(b::Ball, s::Vec) = Ball(Point(b.center.coords .+ s), b.radius)
shift(b::CenteredBall, s::Vec) = Ball(Point(s), b.radius)
shift(b::Box, s::Vec) = Box(Point(minium(b).coords.+s), Point(maximum(b).coords.+s))
shift(b::CenteredBox, s::Vec) = Box(Point(s.-b.l.coords), Point(s.+b.l.coords))


# utils
makepoint(a::Point) = a
makepoint(a) = Point(a)