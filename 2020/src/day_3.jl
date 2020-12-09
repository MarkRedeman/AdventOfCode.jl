using AdventOfCodeSolutions
using Test

function input(puzzle::Puzzle{2020, 3, n}) where n
    io = openInput(puzzle)
    A = split(read(io, String), '\n', keepempty=false)
    return permutedims(hcat(map(collect, A)...))
end

function treesHitUsingSlope(A, slope)
    position = [1, 1]
    trees = 0
    while (position[1] < size(A, 1))
        position[1] = position[1] + slope[1]
        position[2] = mod1(position[2] + slope[2], size(A, 2))

        if (A[position[1], position[2]] == '#')
            trees += 1
        end
    end

    return trees
end

function solve(::Puzzle{2020, 3, 1}, A)
    return treesHitUsingSlope(A, [1, 3])
end

function solve(::Puzzle{2020, 3, 2}, A)
    slopes = [[1, 1], [1, 3], [1, 5], [1, 7], [2, 1]]
    return prod(slope -> treesHitUsingSlope(A, slope), slopes)
end

@testset "Day 3" begin
    @test(solve(Puzzle(3, 1), input(Puzzle(3, 2))) == 173)
    @test(solve(Puzzle(3, 2), input(Puzzle(3, 1))) == 4385176320)
end
