```@meta
CurrentModule = PointProcessFilters
```

# PointProcessFilters

Documentation for [PointProcessFilters](https://github.com/SDS-EPFL/PointProcessFilters.jl).
A package for working filtering point processes.
Currently only provides bandpass filters for a variety of spatial regions.
The basic version is provided by an extension of the `filter` function.

```@docs
filter(::PointSet, ::SpatialFilter)
```

However, convenience functions are provided, see [Available Regions](@ref).
