using AdventOfCodeSolutions
using Test

function input(puzzle::Puzzle{2020, 25, n}) where n
    io = openInput(puzzle)
    split(read(io, String), "\n", keepempty=false)
end

function solve(::Puzzle{2020, 25, 1}, input)
    nothing
end

function solve(::Puzzle{2020, 25, 2}, input)
    nothing
end

@testset "Day 25" begin
    TEST_INPUT_1 = """
"""

    @test_skip(solve(Puzzle(25, 1), TEST_INPUT_1) == nothing)
    @test_skip(solve(Puzzle(25, 1), input(Puzzle(25, 1))) == nothing)

    TEST_INPUT_2 = """
"""

    @test_skip(solve(Puzzle(25, 2), TEST_INPUT_2) == nothing)
    @test_skip(solve(Puzzle(25, 2), input(Puzzle(25, 2))) == nothing)
end
