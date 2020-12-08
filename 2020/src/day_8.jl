# https://adventofcode.com/2020/day/8
using AdventOfCode

function input()
    io = open("2020/data/day_8.txt", "r")
    split(read(io, String), "\n", keepempty=false)
end

function parseInput(input)
    m = match(r"^(nop|acc|jmp) (.\d+)$", input)
    return (m.captures[1], parse(Int, m.captures[2]))
end

function solvePart1(input)
    instructions = map(parseInput, input)
    acc = 0
    loc = 1
    visited = [];
    while (true)
        if loc in visited
            return acc
        end

        push!(visited, loc)
        (operation, argument) = instructions[loc]
        if (operation == "nop")
        elseif (operation == "acc")
            acc += argument
        elseif (operation == "jmp")
            loc += argument
            continue
        end

        loc += 1
    end
    return 5
end

function solvePart2(input)
    1
end

@testset "Day 8" begin
    TEST = """
nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6
"""
    @test(parseInput("nop +0") == ("nop", 0))
    @test(parseInput("acc +4") == ("acc", 4))
    @test(parseInput("jmp -4") == ("jmp", -4))
    @test(solvePart1(split(TEST, '\n', keepempty=false)) == 5)

    @test(solvePart1(input()) == 1586)
    @test_broken(solvePart2(input()) == nothing)
end
