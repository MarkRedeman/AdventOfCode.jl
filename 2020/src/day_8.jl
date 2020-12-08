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

function runInstructions(instructions)
    acc = 0
    loc = 1
    visited = [];
    while (loc <= length(instructions))
        if loc in visited
            throw(acc)
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
    return acc
end

function solvePart1(input)
    instructions = map(parseInput, input)
    try
    runInstructions(instructions)
    catch e
        return e
    end
end

function solvePart2(input)
    instructions = map(parseInput, input)
    for errorLocation = 1:length(instructions)
        instructions = map(parseInput, input)
        try
            if (instructions[errorLocation][1] == "nop")
                instructions[errorLocation] = ("jmp", instructions[errorLocation][2])
            elseif (instructions[errorLocation][1] == "jmp")
                instructions[errorLocation] = ("nop", instructions[errorLocation][2])
            end

            return runInstructions(instructions)
        catch e
            continue
        end
    end
    return nothing
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
    TEST = split(TEST, '\n', keepempty=false)
    @test(parseInput("nop +0") == ("nop", 0))
    @test(parseInput("acc +4") == ("acc", 4))
    @test(parseInput("jmp -4") == ("jmp", -4))
    @test(solvePart1(TEST) == 5)
    @test(solvePart1(input()) == 1586)

    @test(solvePart2(TEST) == 8)
    @test(solvePart2(input()) == 703)
end
