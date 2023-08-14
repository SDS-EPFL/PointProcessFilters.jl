var documenterSearchIndex = {"docs":
[{"location":"regions/#Available-Regions","page":"Available Regions","title":"Available Regions","text":"","category":"section"},{"location":"regions/","page":"Available Regions","title":"Available Regions","text":"The bandpass filtering will filter frequencies within a given region. There are a variety of provided regions, in particular:","category":"page"},{"location":"regions/#Ball","page":"Available Regions","title":"Ball","text":"","category":"section"},{"location":"regions/","page":"Available Regions","title":"Available Regions","text":"circlepass","category":"page"},{"location":"regions/#PointProcessFilters.circlepass","page":"Available Regions","title":"PointProcessFilters.circlepass","text":"circlepass(X::PointSet, p, r)\n\nApplies a circle pass filter with circles centered at p and -p in wavenumber and radii of r.\n\n\n\n\n\n","category":"function"},{"location":"regions/#Centered-Ball","page":"Available Regions","title":"Centered Ball","text":"","category":"section"},{"location":"regions/","page":"Available Regions","title":"Available Regions","text":"centeredcirclepass","category":"page"},{"location":"regions/#PointProcessFilters.centeredcirclepass","page":"Available Regions","title":"PointProcessFilters.centeredcirclepass","text":"centeredcirclepass(X::PointSet{D,T}, r) where {D,T}\n\nApplies a circle pass filter centered at zero, with radius r.\n\n\n\n\n\n","category":"function"},{"location":"regions/#Ring","page":"Available Regions","title":"Ring","text":"","category":"section"},{"location":"regions/","page":"Available Regions","title":"Available Regions","text":"ringpass","category":"page"},{"location":"regions/#PointProcessFilters.ringpass","page":"Available Regions","title":"PointProcessFilters.ringpass","text":"ringpass(X::PointSet{D,T}, a, b) where {D,T}\n\nApplies a ring pass (annulus) filter with the inner radius a and outer radius b.\n\n\n\n\n\n","category":"function"},{"location":"regions/#Box","page":"Available Regions","title":"Box","text":"","category":"section"},{"location":"regions/","page":"Available Regions","title":"Available Regions","text":"boxpass","category":"page"},{"location":"regions/#PointProcessFilters.boxpass","page":"Available Regions","title":"PointProcessFilters.boxpass","text":"boxpass(X::PointSet, a, b)\n\nApplies the box pass filter to boxes with corners a, b and -a, -b.\n\n\n\n\n\n","category":"function"},{"location":"regions/#Centered-Box","page":"Available Regions","title":"Centered Box","text":"","category":"section"},{"location":"regions/","page":"Available Regions","title":"Available Regions","text":"centeredboxpass","category":"page"},{"location":"regions/#PointProcessFilters.centeredboxpass","page":"Available Regions","title":"PointProcessFilters.centeredboxpass","text":"centeredboxpass(X::PointSet, a)\n\nApplies a centered box pass filter, i.e. a box with corners -a, a.\n\n\n\n\n\n","category":"function"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = PointProcessFilters","category":"page"},{"location":"#PointProcessFilters","page":"Home","title":"PointProcessFilters","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for PointProcessFilters. A package for working filtering point processes. Currently only provides bandpass filters for a variety of spatial regions. The basic version is provided by an extension of the filter function.","category":"page"},{"location":"","page":"Home","title":"Home","text":"filter(::PointSet, ::PointProcessFilters.SpatialFilter)","category":"page"},{"location":"","page":"Home","title":"Home","text":"However, convenience functions are provided for some common choices of region, see Available Regions.","category":"page"}]
}