using AdventOfCodeSolutions
using Test
using IterTools
using OffsetArrays

function input(puzzle::Puzzle{2020, 10, n}) where n
    io = openInput(puzzle)
    split(read(io, String), "\n", keepempty=false)
end

function parseInput(input)
    parse.(Int, input)
end

adjacentElements(c) = Iterators.zip(c, Iterators.drop(c, 1))
adjacentDifferences(c) = map(((left, right),) -> right - left, adjacentElements(c))
function solve(::Puzzle{2020, 10, 1}, input)
    adapters = parseInput(input)
    adapters = sort(vcat(0, adapters, maximum(adapters) + 3))
    differences = map(length , groupby(identity, adjacentDifferences(adapters) |> sort))

    return prod(differences)
end

function solve(::Puzzle{2020, 10, 2}, input)
    adapters = vcat(0, sort(parseInput(input)))

    n = length(adapters)
    combinations = zeros(Int64, n)
    combinations[1] = 1
    
    for i = 1:n
        if i + 1 > n
            continue
        end
        if adapters[i + 1] - adapters[i] <= 3
            combinations[i + 1] += combinations[i]
        end
        if i + 2 > n
            continue
        end
        if adapters[i + 2] - adapters[i] <= 3
            combinations[i + 2] += combinations[i]
        end
        if i + 3 > n
            continue
        end
        if adapters[i + 3] - adapters[i] <= 3
            combinations[i + 3] += combinations[i]
        end
    end

    return combinations[end]
end

function solve(::Puzzle{2020, 10, 3}, input)
    adapters = vcat(0, sort(parseInput(input)))
    paths = OffsetVector(zeros(adapters[end] + 4), -1)
    paths[0] = 1

    n = length(adapters)
    for adapter = adapters
        p = paths[adapter]
        paths[adapter + 1] += p
        paths[adapter + 2] += p
        paths[adapter + 3] += p
    end

    return paths[adapters[end]]
end

@testset "Day 10" begin
    TEST_INPUT_1 = """
16
10
15
5
1
11
7
19
6
12
4
"""

    TEST_INPUT_1_2 = """
28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3
"""


    @test(solve(Puzzle(10, 1), split(TEST_INPUT_1, '\n', keepempty=false)) == 7 * 5)
    @test(solve(Puzzle(10, 1), split(TEST_INPUT_1_2, '\n', keepempty=false)) == 22 * 10)
    @test(solve(Puzzle(10, 1), input(Puzzle(10, 1))) == 2432)

    TEST_INPUT_2 = """
"""

    for p = 2:3
        @test(solve(Puzzle(10, p), ["1"]) == 1)
        @test(solve(Puzzle(10, p), ["1", "2"]) == 2)
        @test(solve(Puzzle(10, p), ["1", "2", "3"]) == 4)
        @test(solve(Puzzle(10, p), ["1", "3"]) == 2)
        @test(solve(Puzzle(10, p), ["1", "4"]) == 1)
        @test(solve(Puzzle(10, p), ["1", "2", "3", "4"]) == 7)
        @test(solve(Puzzle(10, p), split(TEST_INPUT_1, '\n', keepempty=false)) == 8)
        @test(solve(Puzzle(10, p), split(TEST_INPUT_1_2, '\n', keepempty=false)) == 19208)
        @test(solve(Puzzle(10, p), input(Puzzle(10, 2))) == 453551299002368)
    end
end
