# https://adventofcode.com/2020/day/6
using AdventOfCode

function input()
    io = open("2020/data/day_6.txt", "r")
    return parseInput(read(io, String))
end

function parseInput(input)
    inputs = split(input, "\n\n")
    x = map(s -> filter(ss -> ss != "", split(s, '\n')), inputs)
    x = map(s -> split(s, '\n', keepempty = false), inputs)
end

function solvePart1(input)
    map(
        answers -> string(answers...) |> unique |> length,
        input
    ) |> sum
end

function solvePart2(input)
    map(input) do answers
        allQuestions = string(answers...) |> unique
        filter(allQuestions) do question
            all(questions -> question in questions, answers)
        end |> length
    end |> sum
end

@testset "Day 6" begin
    @test(solvePart1(input()) == 7128)
    @test(solvePart2(input()) == 3640)
end
