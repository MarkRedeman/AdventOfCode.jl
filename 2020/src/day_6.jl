using AdventOfCodeSolutions
using Test

function input(puzzle::Puzzle{2020, 6, n}) where n
    io = openInput(puzzle)
    return read(io, String)
end

function parseInput(input)
    groups = split(input, "\n\n")
    return map(group -> split(group, '\n', keepempty = false), groups)
end

function solve(::Puzzle{2020, 6, 1}, input)
    sum(
        answers -> string(answers...) |> unique |> length,
        input
    )
end

function solve(::Puzzle{2020, 6, 2}, input)
    return sum(
        answers -> intersect(answers...) |> length,
        input
    )
end

@testset "Day 6" begin
    @test(solve(Puzzle(6, 1), parseInput(input(Puzzle(6, 1)))) == 7128)
    @test(solve(Puzzle(6, 2), parseInput(input(Puzzle(6, 2)))) == 3640)
end
