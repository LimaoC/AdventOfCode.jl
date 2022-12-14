"""
    strsingle(path::String)::String

Converts input file to a single string, omitting the final newline character.

# arguments
* `path` : Path to input file.
"""
strsingle(path::String)::String = open(f -> read(f, String), path)[begin:end-1]

"""
    strvec(path::String; keepempty::Bool = false)::Vector{SubString{String}}

Converts input file to a vector of substrings.

# Arguments
* `path` : Path to input file.
* `dlm` : Delimiter to use for substrings. Defaults to a newline character (`\n`).
# Keyword Arguments
* `keepempty` : Whether to keep empty substrings in the vector. Defaults to false.
"""
function strvec(
    path::String,
    dlm::String = "\n";
    keepempty::Bool = false
)::Vector{SubString{String}}
    split(open(f -> read(f, String), path), dlm, keepempty=keepempty)
end

"""
    strvec2(path::String; keepempty::Bool = false)::Vector{Vector{SubString{String}}}

Converts input file to a vector of vector of substrings, where subvectors are delimited by
an empty line.

# Arguments
* `path` : Path to input file.
# Keyword Arguments
* `keepempty` : Whether to keep empty substrings in the subvectors. Defaults to false.
"""
function strvec2(path::String, keepempty::Bool = false)::Vector{Vector{SubString{String}}}
    split.(
        split(open(f -> read(f, String), path), "\n\n", keepempty=keepempty),
        "\n",
        keepempty=false
    )
end

"""
    intvec(path::String)::Vector{Int64}

Converts input file to a vector of integers.

# Arguments
* `path` : Path to input file.
"""
intvec(path::String)::Vector{Int64} = parse.(Int64, strvec(path))

"""
    intvec2(path::String)::Vector{Vector{Int64}}

Converts input file to a vector of vector of integers, where subvectors are delimited by
an empty line.

# Arguments
* `path` : Path to input file.
"""
intvec2(path::String)::Vector{Vector{Int64}} = map(v -> parse.(Int64, v), strvec2(path))

"""
    intmatrix(path::String)::Matrix{Int64}

Converts input file to a matrix of integers.

# Arguments
* `path` : Path to input file.
"""
function intmatrix(path::String)::Matrix{Int64}
    mapreduce(
        permutedims,
        vcat,
        map(line -> parse.(Int64, split(line, "", keepempty=false)), strvec(path))
    )
end
