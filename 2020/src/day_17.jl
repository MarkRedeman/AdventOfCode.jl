using AdventOfCodeSolutions
using Test

function input(puzzle::Puzzle{2020, 17, n}) where n
    io = openInput(puzzle)
    split(read(io, String), "\n", keepempty=false)
end

function solve(::Puzzle{2020, 17, 1}, input)
    nothing
end

function solve(::Puzzle{2020, 17, 2}, input)
    nothing
end

@testset "Day 17" begin
    TEST_INPUT_1 = """
"""

    @test_skip(solve(Puzzle(17, 1), TEST_INPUT_1) == nothing)
    @test_skip(solve(Puzzle(17, 1), input(Puzzle(17, 1))) == nothing)

    TEST_INPUT_2 = """
"""

    @test_skip(solve(Puzzle(17, 2), TEST_INPUT_2) == nothing)
    @test_skip(solve(Puzzle(17, 2), input(Puzzle(17, 2))) == nothing)
end
