"""
    splitequal(obj, n::Int64)

Splits the given object into n equal sub-objects.

# Arguments
* `obj` : Any object that is indexable.
* `n` : The number of sub-objects to return.

"""
function splitequal(obj, n::Int64)
    length(obj) % n != 0 &&
        throw(ArgumentError("object length should be divisible by n"))
    map(i -> obj[((i-1) * length(obj) ÷ n + 1):(i * length(obj) ÷ n)], 1:n)
end
