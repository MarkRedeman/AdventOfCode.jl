using AdventOfCodeSolutions
using Test

@testset "AdventOfCodeSolutions.jl" begin
    foreach(include, readdir("../2020/src/", join=true))
end
