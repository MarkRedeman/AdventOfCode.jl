using AdventOfCodeSolutions
using Combinatorics
using Test

function input(puzzle::Puzzle{2020, 9, n}) where n
    io = openInput(puzzle)
    split(read(io, String), "\n", keepempty=false)
end

function parseInput(input)
    parse.(Int, input)
end

function findInvalidXmas(numbers, preambleSize, idx)
    n = numbers[idx]
    preamble = @view numbers[idx - preambleSize:idx - 1]

    n in map(sum, combinations(preamble, 2)) ?
        findInvalidXmas(numbers, preambleSize, idx + 1) :
        n
end

function solve(::Puzzle{2020, 9, 1}, input, preambleSize)
    numbers = map(parseInput, input)
    findInvalidXmas(numbers, preambleSize, preambleSize + 1)
end

function findWeakness(numbers, target, left, right)
    r = @view numbers[left:right]
    s = sum(r)
    if (s > target)
        return findWeakness(numbers, target, left + 1, right)
    elseif (s < target)
        return findWeakness(numbers, target, left, right + 1)
    else
        return sum(extrema(r))
    end
end

function solve(::Puzzle{2020, 9, 2}, input, target)
    numbers = map(parseInput, input)
    return findWeakness(numbers, target, 1, 2)
end

@testset "Day 9" begin
    TEST = split("""
35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576
""", '\n', keepempty=false)

    @test(solve(Puzzle(9, 1), TEST, 5) == 127)
    @test(solve(Puzzle(9, 1), input(Puzzle(9, 1)), 25) == 10884537)

    @test(solve(Puzzle(9, 2), TEST, 127) == 62)
    @test(solve(Puzzle(9, 2), input(Puzzle(9, 2)), 10884537) == 1261309)
end

