using PointProcessFilters
using Documenter

DocMeta.setdocmeta!(PointProcessFilters, :DocTestSetup, :(using PointProcessFilters); recursive=true)

makedocs(;
    modules=[PointProcessFilters],
    authors="Jake Grainger",
    repo="https://github.com/SDS-EPFL/PointProcessFilters.jl/blob/{commit}{path}#{line}",
    sitename="PointProcessFilters.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://SDS-EPFL.github.io/PointProcessFilters.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Available Regions" => "regions.md"
    ],
)

deploydocs(;
    repo="github.com/SDS-EPFL/PointProcessFilters.jl",
    devbranch="main",
)
