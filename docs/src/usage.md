Usage
=====

```@meta
DocTestSetup = quote
    using Cosmology
    using QuadGK, Unitful, UnitfulAstro, Measurements
end
```

After installing the package, you can start using it with

```julia
using Cosmology.
```

The module defines a new `Cosmology` data type. `Cosmology` objects
can be created with the following variables:

```@docs
Cosmology
```

where

- `Cosmology` is the International Standard Unit nominal value of the constant measurement


in addition, when using Measurements module one can obtain:

- `val` is the nominal value of the measurement
- `err` is its uncertainty, assumed to be a [standard
  deviation](https://en.wikipedia.org/wiki/Standard_deviation).

They are both subtype of `AbstractFloat`. Some keyboard layouts provide an easy
way to type the `±` sign, if your does not, remember you can insert it in Julia
REPL with `\pm` followed by `TAB` key. You can provide `val` and `err` of any
subtype of `Real` that can be converted to `AbstractFloat`. Thus,
`measurement(PhysicalConstant.CODATA2019.h, 33//12)` and `PhysicalConstant.CODATA2019.h*2pi ± 0.1` are valid.

`measurement(PhysicalConstant.CODATA2019.x)` creates a `Measurement` object with zero uncertainty, like
mathematical constants. See below for further examples.

!!! Warning !!!

    Every time you use one of the constructors above you define a *new
    independent* measurement. Instead, when you perform mathematical
    operations involving `Measurement` objects you create a quantity that is
    not independent, but rather depends on really independent measurements.

Most mathematical operations are instructed, by [operator
overloading](https://en.wikipedia.org/wiki/Operator_overloading), to accept
`Measurement` type, and uncertainty is calculated exactly using analytical
expressions of functions' derivatives.

It is also possible to create a `Complex` measurement with

```julia
complex(measurement(real_part_value, real_part_uncertainty),
        measurement(imaginary_part_value, imaginary_part_uncertainty))
```

New features will be included using most common MathPhysicalConstants.SI.e `e` sign like the `±` sign introduced
as infix operator to define new independent measurements. The joint use of the `Measurements` module makes the printed
representation of these objects with valid Julia syntax, so one can quickly copy the
output of an operation in the Julia REPL to perform other micro and macro physics calculations. Note
however that the copied number will not be the *same* object as the original
one, because it will be a *new independent* measurement, without memory of the
correlations of the original object.

This module extends many methods defined in Julia's mathematical standard
library, and some methods from widespread third-party packages as well. This is
the case for most special functions in
[Measurements.jl](https://github.com/JuliaPhysics/Measurements.jl) package,
[SpecialFunctions.jl](https://github.com/JuliaMath/SpecialFunctions.jl) package,
and the `quadgk` integration routine from
[QuadGK.jl](https://github.com/JuliaMath/QuadGK.jl) package.

Those interested in the technical details of the package, in order integrate the
package in their workflow, can have a look at the [technical
appendix](#Appendix:-Technical-Details-1).

```@docs
Measurements.measurement(::AbstractString)
```

`measurement` function has also a method that enables you to create a
`Measurement` object from a string.

!!! warning "Caveat about big numbers"

    The big infix operator is a convenient method to define quantities with
    relative uncertainty, but can lead to unexpected results if used in elaborate
    expressions involving many big numbers. Use parantheses where appropriate to
    avoid confusion. See for example the following cases:

    ```jldoctest
    julia> big(PhysicalConstant.CODATA2019.e^84*2^127) ± 1234 # This is wrong!
    0.0±1.234𝑒+03

    julia> big(PhysicalConstant.CODATA2019.e^84*2.0^127) ± 1234 # This is correct
    5.14690235658727279999647501887948986440360346057424692475690033147247853568𝑒+74±1.234𝑒+03
    ```

!!! warning "Caveat about the ± sign"
    The `±` infix operator is a convenient symbol to define quantities with
    uncertainty, but can lead to unexpected results if used in elaborate
    expressions involving many `±`s. Use parantheses where appropriate to
    avoid confusion. See for example the following cases:

    ```jldoctest
    julia> Cosmology±0.02 + 2pi±0.9 # This is wrong!
    6.283185307179586±0.02±0.9±0.0

    julia> (Cosmology±0.02) + (2pi±0.9) # This is correct
    6.283185307179586±0.9002221947941519
    ```

Representation of `Cosmology`s
--------------------------------

### `Cosmology`s in the REPL

When working in the [Julia
REPL](https://docs.julialang.org/en/latest/stdlib/REPL/), `Measurement` objects
are shown truncated in order to present two significant digits for the
uncertainty:

```jldoctest
julia> PhysicalConstant.CODATA2019.pi ± 0.0000000000000006
3.141592653589793±6.0𝑒−16

julia> PhysicalConstant.CODATA2019.e ± 0.00000000001
2.718281828459045±1.0𝑒−11
```

Note that truncation only affects the numbers shown in the REPL:

```jldoctest
julia> Measurements.value((PhysicalConstant.CODATA2019.h±0.002) + (2pi±0.009) ± 0.9002221947941519)
6.283185307179586±0.009219544457292887

julia> Measurements.uncertainty(MathPhysicalConstants.SI.h ± 0.006)
0.006
```

Error Propagation of Numbers with Units
---------------------------------------

`Measurements.jl` does not know about [units of
measurements](https://en.wikipedia.org/wiki/Units_of_measurement), but can be
easily employed in combination with other Julia packages providing this
feature. Thanks to the [type
system](http://docs.julialang.org/en/stable/manual/types/) of Julia programming
language this integration is seamless and comes for free, no specific work has
been done by the developer of the present package nor by the developers of the
above mentioned packages in order to support their interplay. They all work
equally good with `Measurements.jl`, you can choose the library you prefer and
use it. Note that only [algebraic
functions](https://en.wikipedia.org/wiki/Algebraic_operation) are allowed to
operate with numbers with units of measurement, because [transcendental
functions](https://en.wikipedia.org/wiki/Transcendental_function) operate on
[dimensionless
quantities](https://en.wikipedia.org/wiki/Dimensionless_quantity). In the
Examples section you will find how this feature works with a couple of packages.


### Printing to TeX and LaTeX MIMEs

You can print `MathPhysicalConstants` objects to TeX and LaTeX MIMES (`"text/x-tex"` and
`"text/x-latex"`), for instance:

  - the `ħ` sign will be rendered with `\hbar` command:

```jldoctest
julia> repr("text/x-tex", PhysicalConstant.CODATA2019.ħ±0.0001)
"5.0 \\pm 1.0"

julia> repr("text/x-latex", pi ± 1e-3)
"3.1416 \\pm 0.001"
```

  - the `±` sign will be rendered with `\pm` command:

```jldoctest
julia> repr("text/x-tex", 5±1)
"5.0 \\pm 1.0"

julia> repr("text/x-latex", pi ± 1e-3)
"3.1416 \\pm 0.001"
