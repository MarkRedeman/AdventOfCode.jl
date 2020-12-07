using Test

function input()
    io = open("2020/data/day_3.txt", "r")
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

function solvePart1(A)
    return treesHitUsingSlope(A, [1, 3])
end

function solvePart2(A)
    slopes = [[1, 1], [1, 3], [1, 5], [1, 7], [2, 1]]
    return prod(slope -> treesHitUsingSlope(A, slope), slopes)
end

@testset "Day 3" begin
    @test(solvePart1(input()) == 173)
    @test(solvePart2(input()) == 4385176320)
end
