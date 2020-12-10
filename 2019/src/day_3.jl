using AdventOfCodeSolutions
using Test
import LinearAlgebra: norm

function input(puzzle::Puzzle{2019, 3, n}) where n
    io = openInput(puzzle)
    return read(io, String)
end

function parseInput(puzzle::Puzzle{2019, 3, n}, input) where n
    map(s -> split(s, ','), split(input, '\n', keepempty=false))
end

function path(turns)
    dirMap = Dict('R' => [1 0], 'L' => [-1 0], 'U' => [0 1], 'D' => [0 -1])
    path = [[0 0]]
    foreach(map(d -> (dirMap[d[1]], parse(Int, d[2:end])), turns)) do turn
        foreach(d -> push!(path, path[end] + turn[1]), 1:turn[2])
    end
    return path[2:end]
end

manhattan(p) = norm(p, 1)
function solve(p::Puzzle{2019, 3, 1}, input)
    turns = parseInput(p, input)

    return minimum(
        manhattan,
        intersect(path(turns[1]), path(turns[2]))
    )
end

function solve(p::Puzzle{2019, 3, 2}, input)
    turns = parseInput(p, input)

    p1 = path(turns[1])
    p2 = path(turns[2])
    intersections = intersect(p1, p2)
    minimum(intersections) do point
        i1 = minimum(findall(==(point), p1))
        i2 = minimum(findall(==(point), p2))

        return i1 + i2
    end
end

@testset "Day 3" begin
    TEST_INPUT_1 = """
R75,D30,R83,U83,L12,D49,R71,U7,L72
U62,R66,U55,R34,D71,R55,D58,R83
"""
    TEST_INPUT_2 = """
R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
U98,R91,D20,R16,D67,R40,U7,R15,U6,R7
"""
    @test(solve(Puzzle(2019, 3, 1), TEST_INPUT_1) == 159)
    @test(solve(Puzzle(2019, 3, 1), TEST_INPUT_2) == 135)
    @test(solve(Puzzle(2019, 3, 1), input(Puzzle(2019, 3, 1))) == 1084)
    @test(solve(Puzzle(2019, 3, 2), input(Puzzle(2019, 3, 2))) == 9240)
end
