using AdventOfCodeSolutions
using Test

function input(puzzle::Puzzle{2020, 14, n}) where n
    io = openInput(puzzle)
    split(read(io, String), "\n", keepempty=false)
end

function solve(::Puzzle{2020, 14, 1}, inputt)
    nothing
end

function solve(::Puzzle{2020, 14, 2}, inputt)
    nothing
end

@testset "Day 14" begin
    TEST_INPUT_1 = """
"""

    @test_skip(solve(Puzzle(14, 1), TEST_INPUT_1) == nothing)
    @test_skip(solve(Puzzle(14, 1), input(Puzzle(14, 1))) == nothing)

    TEST_INPUT_2 = """
"""

    @test_skip(solve(Puzzle(14, 2), TEST_INPUT_2) == nothing)
    @test_skip(solve(Puzzle(14, 2), input(Puzzle(14, 2))) == nothing)
end
