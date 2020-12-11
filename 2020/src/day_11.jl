using AdventOfCodeSolutions
using Test

function input(puzzle::Puzzle{2020, 11, n}) where n
    io = openInput(puzzle)
    return split(read(io, String), '\n', keepempty=false)
end

function parseInput(input)
    return permutedims(hcat(map(collect, input)...))
end

function countTakenSeats(A, i, j)
    (n, m) = size(A)
    count(
        idx -> A[idx[1], idx[2]] == '#',
        filter(
            !=([i,j]),
            [[l,k] for l = (max(1, i - 1) : min(i + 1, n)), k=max(1, j - 1):min(j + 1, m)]
        )
    )
end

function countTakenSeatsInSight(A, i, j)
    (n, m) = size(A)
    directions = filter(!=([0 0]), [[i j] for i=-1:1, j=-1:1])
    count(directions) do (direction)
        p = [i j]

        p += direction
        while (p[1] ∈ 1:n && p[2] ∈ 1:m)
            if (A[p[1], p[2]] == '#')
                return true
            end
            if (A[p[1], p[2]] == 'L')
                return false
            end

            p += direction
        end
        return false
    end
end

"""
If a seat is empty (L) and there are no occupied seats adjacent to it, the seat becomes occupied.
If a seat is occupied (#) and four or more seats adjacent to it are also occupied, the seat becomes empty.
Otherwise, the seat's state does not change.
"""
function iterateInnerNeighbours(A, result, i, j)
    if A[i, j] == '.'
        return
    end

    takenSeats = countTakenSeats(A, i, j)
    if A[i, j] == 'L' && takenSeats == 0
        result[i, j] = '#'
    end
    if A[i, j] == '#' && takenSeats >= 4
        result[i, j] = 'L'
    end
end

"""
If a seat is empty (L) and there are no occupied seats adjacent to it, the seat becomes occupied.
If a seat is occupied (#) and five or more seats in sight are also occupied, the seat becomes empty.
Otherwise, the seat's state does not change.
"""
function iterateInnerSight(A, result, i, j)
    if A[i, j] == '.'
        return
    end

    takenSeats = countTakenSeatsInSight(A, i, j)
    if A[i, j] == 'L' && takenSeats == 0
        result[i, j] = '#'
    end
    if A[i, j] == '#' && takenSeats >= 5
        result[i, j] = 'L'
    end
end


function iterate(A, iterateFn = iterateInnerNeighbours)
    result = copy(A)
    n, m = size(A)

    for i = 1:n, j =1:m
        iterateFn(A, result, i, j)
    end

    return result
end
iterateNeighbours(A) = iterate(A, iterateInnerNeighbours)
iterateSight(A) = iterate(A, iterateInnerSight)

function solveProblem(A, iterateFn)
    converged = false
    iterations = 0
    while converged != true
        iterations += 1
        previousA = copy(A)
        A = iterateFn(previousA)

        if (A == previousA)
            break
        end

        if iterations > 10000
            @show "HOI"
            break
        end
    end
    count(v -> v == '#', A)
end

function solve(::Puzzle{2020, 11, 1}, input)
    A = parseInput(input)
    return solveProblem(A, iterateNeighbours)
end

function solve(::Puzzle{2020, 11, 2}, input)
    A = parseInput(input)
    return solveProblem(A, iterateSight)
end

@testset "Day 11" begin
    @testset "Examples" begin

        @testset "Neighbouring taken seats" begin
            @test iterateNeighbours(['.' '.' '.'; '.' 'L' '.'; '.' '.' '.';]) == ['.' '.' '.'; '.' '#' '.'; '.' '.' '.';]
            @test iterateNeighbours(['.' '.' '.'; '.' '#' '.'; '.' '.' '.';]) == ['.' '.' '.'; '.' '#' '.'; '.' '.' '.';]
            @test iterateNeighbours(['#' '.' '#'; '#' '#' '#'; '#' '.' '#';]) == ['#' '.' '#'; '#' 'L' '#'; '#' '.' '#';]
        end


        @testset "Takenseats in sight" begin
            INPUT = """
.......#.
...#.....
.#.......
.........
..#L....#
....#....
.........
#........
...#.....
"""

            A = split(INPUT, '\n', keepempty=false) |> parseInput
            @test countTakenSeatsInSight(A, 5, 4) == 8

            INPUT = """
.............
.L.L.#.#.#.#.
.............
"""
            A = split(INPUT, '\n', keepempty=false) |> parseInput
            @test countTakenSeatsInSight(A, 2, 2) == 0

            INPUT = """
.##.##.
#.#.#.#
##...##
...L...
##...##
#.#.#.#
.##.##.
"""
            A = split(INPUT, '\n', keepempty=false) |> parseInput
            @test countTakenSeatsInSight(A, 4, 4) == 0



            INPUT = """
L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL
"""
            A = split(INPUT, '\n', keepempty=false) |> parseInput

            INPUT = """
#.##.##.##
#######.##
#.#.#..#..
####.##.##
#.##.##.##
#.#####.##
..#.#.....
##########
#.######.#
#.#####.##"""
            expectedA = split(INPUT, '\n', keepempty=false) |> parseInput


            @test iterateSight(A) == expectedA

            INPUT="""
#.LL.LL.L#
#LLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLL#
#.LLLLLL.L
#.LLLLL.L#
"""
            expectedA2 = split(INPUT, '\n', keepempty=false) |> parseInput
            @test iterateSight(expectedA) == expectedA2

            INPUT="""
#.L#.##.L#
#L#####.LL
L.#.#..#..
##L#.##.##
#.##.#L.##
#.#####.#L
..#.#.....
LLL####LL#
#.L#####.L
#.L####.L#
"""
            expectedA3 = split(INPUT, '\n', keepempty=false) |> parseInput
            @test iterateSight(expectedA2) == expectedA3
        end


    end
    TEST_INPUT_1 = """
L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL
"""

    @test(solve(Puzzle(11, 1), split(TEST_INPUT_1, '\n', keepempty=false)) == 37)
    @test(solve(Puzzle(11, 1), input(Puzzle(11, 1))) == 2489)

    @test(solve(Puzzle(11, 2), split(TEST_INPUT_1, '\n', keepempty=false)) == 26)
    @test(solve(Puzzle(11, 2), input(Puzzle(11, 2))) == 2180)
end
