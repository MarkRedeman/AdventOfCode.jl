using Combinatorics
using Test

function input()
    io = open("2020/data/day_9.txt", "r")
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

function solvePart1(input, preambleSize)
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

function solvePart2(input, target)
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

    @test(solvePart1(TEST, 5) == 127)
    @test(solvePart1(input(), 25) == 10884537)

    @test(solvePart2(TEST, 127) == 62)
    @test(solvePart2(input(), 10884537) == 1261309)
end
