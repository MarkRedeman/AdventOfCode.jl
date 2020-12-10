using AdventOfCodeSolutions
using Test
import IterTools: groupby

function input(puzzle::Puzzle{2019, 4, n}) where n
    io = openInput(puzzle)
    inputs = split(read(io, String), '-', keepempty=false)
    return parse.(Int, inputs)
end

function isValidPassword(password)
    it = adjacentElements(digits(password))

    return any(((l,r),) -> l == r, it) &&
        all(((l,r),) -> l >= r, it)
end

function solve(::Puzzle{2019, 4, 1}, input)
    count(isValidPassword, input[1]:input[end])
end

function isValidPassword2(password)
    it = adjacentElements(digits(password))

    doubleDigits = Iterators.filter(((l,r),) -> l == r, it)

    return in(1 , map(length, groupby(identity, doubleDigits))) &&
        all(((l,r),) -> l >= r, it)
end

function solve(::Puzzle{2019, 4, 2}, input)
    count(isValidPassword2, input[1]:input[end])
end

@testset "Day 4" begin
    @test isValidPassword(111111) == true
    @test isValidPassword(223450) == false
    @test isValidPassword(123789) == false
    @test (solve(Puzzle(2019, 4, 1), input(Puzzle(2019, 4, 1))) == 2779)

    @test isValidPassword2(112233) == true
    @test isValidPassword2(123444) == false
    @test isValidPassword2(111122) == true
    @test (solve(Puzzle(2019, 4, 2), input(Puzzle(2019, 4, 2))) == 1972)
end
