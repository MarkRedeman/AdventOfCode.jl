using AdventOfCodeSolutions
using Test

function input(puzzle::Puzzle{8, n}) where n
    io = openInput(puzzle)
    split(read(io, String), "\n", keepempty=false)
end

function parseInput(input)
    m = match(r"^(nop|acc|jmp) (.\d+)$", input)
    argument = parse(Int, m.captures[2])
    return (operation = m.captures[1], argument )
end

struct InfiniteLoopDetected <: Exception
    location::Int
    accumulator::Int
end

function runInstruction(instruction, state)
    (operation, argument) = instruction

    if (operation == "nop")
        return (loc = state.loc + 1, acc = state.acc)
    elseif (operation == "acc")
        return (loc = state.loc + 1, acc = state.acc + argument)
    elseif (operation == "jmp")
        return (loc = state.loc + argument, acc = state.acc)
    end

    throw(ArgumentError("Got an unkown operation: $operation"))
end

function visitInstruction!(visited, state)
    (loc, acc) = state
    if loc in visited
        throw(InfiniteLoopDetected(loc, acc))
    else
        push!(visited, loc)
    end
end

function runInstructions(instructions)
    acc = 0
    loc = 1
    state = (loc = loc, acc = acc)
    visited = [];
    while (state.loc <= length(instructions))
        visitInstruction!(visited, state)

        state = runInstruction(instructions[state.loc], state)
    end
    return state.acc
end

function solve(::Puzzle{8, 1}, input)
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

function switchOperation((operation, argument))
    if (operation == "nop")
        return (operation = "jmp", argument)
    elseif (operation == "jmp")
        return (operation = "nop", argument)
    end

    throw(ArgumentError("Got an unkown operation: $operation"))
end

function repairBootCode!(instructions, errorLocation)
    instruction = instructions[errorLocation]

    if (instruction[1] ∉ ["jmp", "nop"])
        return false
    end

    instructions[errorLocation] = switchOperation(instruction)
    return true
end

function solve(::Puzzle{8, 2}, input)
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

    @test(parseInput("nop +0") == (operation = "nop", argument = 0))
    @test(parseInput("acc +4") == (operation = "acc", argument = 4))
    @test(parseInput("jmp -4") == (operation = "jmp", argument = -4))
    @test(solve(Puzzle(8, 1), TEST) == 5)
    @test(solve(Puzzle(8, 1), input(Puzzle(8, 1))) == 1586)

    @test(solve(Puzzle(8, 2), TEST) == 8)
    @test(solve(Puzzle(8, 2), input(Puzzle(8, 2))) == 703)
end
