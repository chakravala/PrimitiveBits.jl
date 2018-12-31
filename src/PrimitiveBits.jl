module PrimitiveBits

#   This file is part of PrimitiveBits.jl. It is licensed under the MIT license
#   Copyright (C) 2019 Michael Reed

function Declare(b::Int)
    sym = Symbol("PrimitiveBits$b")
    int = Symbol("UInt$b")
    def = Expr(:primitive,sym,b)
    exp = Expr(:export,sym)
    fun = quote
        $sym(b::$int) = reinterpret($sym,b)
        Base.$int(b::$sym) = reinterpret($int,b)
        function Base.getindex(b::$sym,i::I) where I<:Integer
            d = $int(2)^(i-1)
            return (d & $int(b)) == d
        end
        Base.getindex(b::$sym,i::UnitRange{<:Integer}) = [getindex(b,j) for j ∈ i]
        Base.getindex(b::$sym,i::Colon) = [getindex(b,j) for j ∈ 1:$b]
        Base.firstindex(::$sym) = 1
        Base.lastindex(::$sym) = $b
        Base.length(::$sym) = $b
        function Base.iterate(b::$sym,i::Int=1)
            Base.@_inline_meta
            length(r) < i && return nothing
            Base.unsafe_getindex(b,i), i + 1
        end
        $sym(b::I) where I<:Integer = $sym(convert($int,b))
        function $sym(b::Union{BitArray{1},Vector{Bool}})
            $sym(parse($int,join([t ? '1' : '0' for t ∈ reverse(b)]),base=2))
        end
        Base.print(io::IO,b::$sym) = print(io,'[',[Int(b[i]) for i ∈ 1:$b]...,']')
        Base.show(io::IO,b::$sym) = print(io,b)
    end
    eval(Expr(:block,def,exp,fun.args...))
end

for b ∈ [8,16,32,64,128]
    Declare(b)
end

end # module
