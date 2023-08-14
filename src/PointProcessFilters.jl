module PointProcessFilters

using LinearAlgebra, Meshes, SpecialFunctions
import Base: filter

include("regions.jl")
include("regionpass.jl")
include("boxpass.jl")
include("circlepass.jl")

export 
    filter, 
    impulse_response, 
    ringpass, 
    boxpass, 
    circlepass, 
    centeredboxpass, 
    centeredcirclepass,
    RegionPassFilter,
    Point,
    PointSet

end
