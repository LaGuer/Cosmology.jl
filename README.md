Cosmology calculator for Julia
==============================

[![Coverage Status](http://img.shields.io/coveralls/LaGuer/Cosmology.jl.svg?style=flat-square)](https://coveralls.io/r/LaGuer/Cosmology.jl?branch=master)
[![Build status](https://ci.appveyor.com/api/projects/status/8w554f36u0aj8vu5/branch/master?svg=true)](https://ci.appveyor.com/project/LaGuer/cosmology-jl/branch/master)
[![codecov](https://codecov.io/gh/LaGuer/Cosmology.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/LaGuer/Cosmology.jl)
[![Travis](https://travis-ci.org/LaGuer/Cosmology.jl.svg?branch=master)](https://travis-ci.org/LaGuer/Cosmology.jl)
[![MyBinder](http://mybinder.org/badge.svg)](https://mybinder.org/v2/gh/laguer/cosmology.jl/master)

Installation
------------

To install the package:

```jlcon
julia> Pkg.add("Cosmology")
```

Then, to load into your session:

```jlcon
julia> using Cosmology
```

Cosmological Models
-------------------

First, pick a cosmological model using the `cosmology` function,
which takes the following options:

<table>
  <tr>
    <td>h = 0.7079</td>
    <td>Dimensionless Hubble constant</td>
  </tr>
  <tr>
    <td>OmegaK = 0</td>
    <td>Curvature density, Ω<sub>k</sub></td>
  </tr>
  <tr>
    <td>OmegaM = 0.29</td>
    <td>Matter density, Ω<sub>m</sub></td>
  </tr>
  <tr>
    <td>OmegaR = Ω<sub>γ</sub> + Ω<sub>ν</sub></td>
    <td>Radiation density, Ω<sub>r</sub></td>
  </tr>
  <tr>
    <td>Tcmb = 2.725820831</td>
    <td>CMB temperature (K), used to compute Ω<sub>γ</sub></td>
  </tr>
  <tr>
    <td>Neff = 3.04</td>
    <td>Effective number of massless neutrino species, used to compute Ω<sub>ν</sub></td>
  </tr>
  <tr>
    <td>w0 = -1</td>
    <td>CPL dark energy equation of state, w = w0 + wa*(1-a)</td>
  </tr>
  <tr>
    <td>wa = 0</td>
    <td>CPL dark energy equation of state, w = w0 + wa*(1-a)</td>
  </tr>
</table>

```jlcon
julia> using Cosmology

julia> C = cosmology()
Cosmology.FlatLCDM{Float64}(0.7079, 0.6999165470916852, 0.3, 8.345290831484895e-5)

julia> C = cosmology(OmegaK=0.1)
Cosmology.OpenLCDM{Float64}(0.7079, 0.1, 0.5999165470916853, 0.3, 8.345290831484895e-5)

julia> c = cosmology(w0=-0.9, OmegaK=-0.1)
Cosmology.ClosedWCDM{Float64}(0.7079, -0.1, 0.7999165470916852, 0.3, 8.345290831484895e-5, -0.9, 0.0)
```

Distances
---------

<table>
  <tr>
    <td>angular_diameter_dist_mpc(cosmo,&nbsp;z)</td>
    <td>Ratio of an object's proper transverse size (in Mpc) to its angular size (in radians)</td>
  </tr>
  <tr>
    <td>comoving_radial_dist_mpc(cosmo,&nbsp;z)</td>
    <td>Comoving radial distance to redshift z, in Mpc</td>
  </tr>
  <tr>
    <td>comoving_volume_gpc3(cosmo,&nbsp;z)</td>
    <td>Comoving volume out to redshift z, in Gpc<sup>3</sup></td>
  </tr>
  <tr>
    <td>luminosity_dist_mpc(cosmo, z)</td>
    <td>Bolometric luminosity distance, in Mpc</td>
  </tr>
  <tr>
    <td>distmod(cosmo, z)</td>
    <td>Distance modulus, in units of magnitude</td>
  </tr>
</table>

```jlcon
julia> using Cosmology

julia> C = cosmology(OmegaM=0.27)
Cosmology.FlatLCDM{Float64}(0.7079, 0.6999165470916852, 0.27, 8.345290831484895e-5)

julia> luminosity_dist(C, 1)
6653.8655390874155 Mpc

julia> angular_diameter_dist_mpc(C, 1)
1663.4663847718539 Mpc

julia> comoving_radial_dist(C, 1)
3326.9327695437078 Mpc

```

Times
-----

<table>
  <tr>
    <td>age_gyr(cosmo, z)</td>
    <td>Age of the universe at redshift z, in Gyr</td>
  </tr>
  <tr>
    <td>lookback_time_gyr(cosmo, z)</td>
    <td>Difference between age at redshift 0 and age at redshift z, in Gyr</td>
  </tr>
</table>

```jlcon
julia> using Cosmology

julia> C = cosmology(OmegaM=0.27)
Cosmology.FlatLCDM{Float64}(0.7079, 0.7299165470916852, 0.27, 8.345290831484895e-5)

julia> age(C, 0)
13.705983172937254 Gyr

julia> age(C, 1)
5.952350017688919 Gyr
```

Cite
-----

[Back to cosmos](http://rxiv.org/abs/1904.0218) 
