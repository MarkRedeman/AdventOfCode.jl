using Combinatorics
using Test

function input()
    io = open("2020/data/day_9.txt", "r")
    split(read(io, String), "\n", keepempty=false)
end

function parseInput(input)
    parse.(Int, input)
end

function solvePart1(input, preambleSize)
    numbers = map(parseInput, input)
    windows = Iterators.zip([Iterators.drop(numbers, n) for n = 0:preambleSize]...)
    for iterators in windows
        preamble, n = iterators[1:end-1], iterators[end]

        if (n ∉ map(sum, combinations(preamble, 2)))
            return n
        end
    end
end

function solvePart2(input, target)
    numbers = map(parseInput, input)

    for left = 1:length(numbers)
        for right = left + 1 : length(numbers)
            r = (numbers[left:right])
            s = sum(r)
            if (s > target)
                break
            end

            if (s == target)
                return min(r...) + max(r...)
            end
        end
    end

    return nothing
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
    # @test(solvePart1(input(), 25) == 10884537)

    @test(solvePart2(TEST, 127) == 62)
    @test(solvePart2(input(), 10884537) == 1261309)
    # @test(solvePart2(input()) == 703)
end
