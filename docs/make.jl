using Documenter, Cosmology
using QuadGK, Unitful, UnitfulAstro
import Unitful: km, s
using UnitfulAstro: Mpc, Gpc, Gyr
using FileIO

makedocs(
    modules = [Cosmology],
    clean = false,
    format = Documenter.HTML(),
    sitename = "Cosmology",
    authors = "La Guer.",
    pages    = Any[
        "Introduction" => "index.md",
        "Usage"        => "usage.md",
        "api"          => "api.md",
    ]
)

deploydocs(
    julia = "nightly",
    repo = "github.com/LaGuer/Cosmology.jl.git",
    target = "build",
    deps = Deps.pip("Tornado>=4.0.0,<5.0.0", "mkdocs==0.17.5", "mkdocs-material==2.9.4", "python-markdown-math"),
    make = nothing,
)
