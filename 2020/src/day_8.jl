using Test

function input()
    io = open("2020/data/day_8.txt", "r")
    split(read(io, String), "\n", keepempty=false)
end

function parseInput(input)
    m = match(r"^(nop|acc|jmp) (.\d+)$", input)
    return (m.captures[1], parse(Int, m.captures[2]))
end

struct InfiniteLoopDetected <: Exception
    location::Int
    accumulator::Int
end

function runInstruction(instruction, state)
    (operation, argument) = instruction
    (loc, acc) = state

    if (operation == "nop")
        return (loc + 1, acc)
    elseif (operation == "acc")
        return (loc + 1, acc + argument)
    elseif (operation == "jmp")
        return (loc + argument, acc)
    end

    throw(ArgumentError("Got an unkown operation: $operation"))
end

function runInstructions(instructions)
    acc = 0
    loc = 1
    visited = [];
    while (loc <= length(instructions))
        if loc in visited
            throw(InfiniteLoopDetected(loc, acc))
        end

        push!(visited, loc)
        (loc, acc) = runInstruction(instructions[loc], (loc, acc))
    end
    return acc
end

function solvePart1(input)
    instructions = map(parseInput, input)
    try
        runInstructions(instructions)
    catch e
        if (typeof(e) == InfiniteLoopDetected)
            return e.accumulator
        end
        throw(e)
    end
end

function repairBootCode!(instructions, errorLocation)
    (operation, argument) = instructions[errorLocation]

    if (operation ∉ ["jmp", "nop"])
        return false
    end

    if (operation == "nop")
        instructions[errorLocation] = ("jmp", argument)
    elseif (operation == "jmp")
        instructions[errorLocation] = ("nop", argument)
    end
    return true
end

function solvePart2(input)
    instructions = map(parseInput, input)
    for errorLocation = 1:length(instructions)
        if (repairBootCode!(instructions, errorLocation) == false)
            continue
        end

        try
            return runInstructions(instructions)
        catch e
            if (typeof(e) == InfiniteLoopDetected)
                repairBootCode!(instructions, errorLocation)
                continue
            end
            throw(e)
        end
    end
    return nothing
end

@testset "Day 8" begin
    TEST = split("""
nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6
""", '\n', keepempty=false)

    @test(parseInput("nop +0") == ("nop", 0))
    @test(parseInput("acc +4") == ("acc", 4))
    @test(parseInput("jmp -4") == ("jmp", -4))
    @test(solvePart1(TEST) == 5)
    @test(solvePart1(input()) == 1586)

    @test(solvePart2(TEST) == 8)
    @test(solvePart2(input()) == 703)
end
