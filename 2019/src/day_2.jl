using AdventOfCodeSolutions
using Test
using OffsetArrays

function input(puzzle::Puzzle{2019, 2, n}) where n
    io = openInput(puzzle)
    inputs = split(read(io, String), ',', keepempty=false)
    return parse.(Int, inputs)
end

function runIntCode(memory)
    location = 0

    while (true)
        opcode = memory[location]

        if (opcode == 1)
            (left, right, output) = memory[location + 1:location + 3]
            memory[output] = sum(memory[[left, right]])
        end
        if (opcode == 2)
            (left, right, output) = memory[location + 1:location + 3]
            memory[output] = prod(memory[[left, right]])
        end

        if (opcode == 99)
            break
        end
        location += 4
    end

    return memory
end

function runWithInput(memory, noun, verb)
    memory[1] = noun
    memory[2] = verb
    runIntCode(memory)
end

function solve(::Puzzle{2019, 2, 1}, input)
    runWithInput(OffsetVector(input, -1), 12, 2)[0]
end

function solve(::Puzzle{2019, 2, 2}, input)
    (noun, verb) = Iterators.filter(
        ((noun, verb),) -> runWithInput(OffsetVector(copy(input), -1), noun, verb)[0] == 19690720,
        Iterators.product(0:99, 0:99)
    ) |>first

    return 100 * noun + verb
end

@testset "Day 2" begin
    @test runIntCode(OffsetVector([1,0,0,0,99], -1)) == OffsetVector([2,0,0,0,99], -1)
    @test runIntCode(OffsetVector([2,3,0,3,99], -1)) == OffsetVector([2,3,0,6,99], -1)
    @test runIntCode(OffsetVector([2,4,4,5,99,0], -1)) == OffsetVector([2,4,4,5,99,9801], -1)
    @test runIntCode(OffsetVector([1,1,1,4,99,5,6,0,99], -1)) == OffsetVector([30,1,1,4,2,5,6,0,99], -1)

    @test (solve(Puzzle(2019, 2, 1), input(Puzzle(2019, 2, 1))) == 5866714)
    @test (solve(Puzzle(2019, 2, 2), input(Puzzle(2019, 2, 2))) == 5208)
end
