# https://adventofcode.com/2020/day/6
using AdventOfCode

function input()
    io = open("2020/data/day_6.txt", "r")
    return read(io, String)
end

function parseInput(input)
    groups = split(input, "\n\n")
    return map(group -> split(group, '\n', keepempty = false), groups)
end

function solvePart1(input)
    sum(
        answers -> string(answers...) |> unique |> length,
        input
    )
end

function solvePart2(input)
    return sum(
        answers -> intersect(answers...) |> length,
        input
    )
end

@testset "Day 6" begin
    @test(solvePart1(parseInput(input())) == 7128)
    @test(solvePart2(parseInput(input())) == 3640)
end
