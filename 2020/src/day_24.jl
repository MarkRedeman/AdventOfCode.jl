using AdventOfCodeSolutions
using Test

function input(puzzle::Puzzle{24, n}) where n
    io = openInput(puzzle)
    split(read(io, String), "\n", keepempty=false)
end

function solve(::Puzzle{24, 1}, inputt)
    nothing
end

function solve(::Puzzle{24, 2}, inputt)
    nothing
end

@testset "Day 24" begin
    TEST_INPUT_1 = """
"""

    @test_skip(solve(Puzzle(24, 1), TEST_INPUT_1) == nothing)
    @test_skip(solve(Puzzle(24, 1), input(Puzzle(24, 1))) == nothing)

    TEST_INPUT_2 = """
"""

    @test_skip(solve(Puzzle(24, 2), TEST_INPUT_2) == nothing)
    @test_skip(solve(Puzzle(24, 2), input(Puzzle(24, 2))) == nothing)
end