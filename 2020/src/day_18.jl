using AdventOfCodeSolutions
using Test

function input(puzzle::Puzzle{2020, 18, n}) where n
    io = openInput(puzzle)
    split(read(io, String), "\n", keepempty=false)
end

function solve(::Puzzle{2020, 18, 1}, inputt)
    nothing
end

function solve(::Puzzle{2020, 18, 2}, inputt)
    nothing
end

@testset "Day 18" begin
    TEST_INPUT_1 = """
"""

    @test_skip(solve(Puzzle(18, 1), TEST_INPUT_1) == nothing)
    @test_skip(solve(Puzzle(18, 1), input(Puzzle(18, 1))) == nothing)

    TEST_INPUT_2 = """
"""

    @test_skip(solve(Puzzle(18, 2), TEST_INPUT_2) == nothing)
    @test_skip(solve(Puzzle(18, 2), input(Puzzle(18, 2))) == nothing)
end
