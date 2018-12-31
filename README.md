# PrimitiveBits.jl

*Static bit-vector types with primitive byte storage and bit-wise indexing*

[![Build Status](https://travis-ci.org/chakravala/PrimitiveBits.jl.svg?branch=master)](https://travis-ci.org/chakravala/PrimitiveBits.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/l2257dcbbfwtv9pu?svg=true)](https://ci.appveyor.com/project/chakravala/primitivebits-jl)
[![Coverage Status](https://coveralls.io/repos/chakravala/PrimitiveBits.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/chakravala/PrimitiveBits.jl?branch=master)
[![codecov.io](http://codecov.io/github/chakravala/PrimitiveBits.jl/coverage.svg?branch=master)](http://codecov.io/github/chakravala/PrimitiveBits.jl?branch=master)

## Usage

```Julia
julia> using PrimitiveBits

julia> b = PrimitiveBits16(7)
[1110000000000000]

julia> b[2:4]
3-element Array{Bool,1}:
  true
  true
 false
```

