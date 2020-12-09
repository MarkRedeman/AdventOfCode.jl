using AdventOfCodeSolutions
using Test

function input(puzzle::Puzzle{2020, 13, n}) where n
    io = openInput(puzzle)
    split(read(io, String), "\n", keepempty=false)
end

function solve(::Puzzle{2020, 13, 1}, inputt)
    nothing
end

function solve(::Puzzle{2020, 13, 2}, inputt)
    nothing
end

@testset "Day 13" begin
    TEST_INPUT_1 = """
"""

    @test_skip(solve(Puzzle(13, 1), TEST_INPUT_1) == nothing)
    @test_skip(solve(Puzzle(13, 1), input(Puzzle(13, 1))) == nothing)

    TEST_INPUT_2 = """
"""

    @test_skip(solve(Puzzle(13, 2), TEST_INPUT_2) == nothing)
    @test_skip(solve(Puzzle(13, 2), input(Puzzle(13, 2))) == nothing)
end
