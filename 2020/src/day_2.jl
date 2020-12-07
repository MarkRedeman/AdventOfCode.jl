# https://adventofcode.com/2020/day/2
using AdventOfCode
using Test

function input()
    io = open("2020/data/day_2.txt", "r")
    return split(read(io, String), '\n', keepempty=false)
end

function parsePassword(s)
    range, char, password = split(s, ' ')
    left, right = parse.(Int, split(range, '-'))

    return (left:right, char[1], password)
end

function isValidPart1(s)
    range, char, password = parsePassword(s)

    return count(==(char), password) ∈ range
end

solvePart1(input) = count(isValidPart1, input)

function isValidPart2(s)
    range, char, password = parsePassword(s)

    return xor(password[range.start] == char, password[range.stop] == char)
end

solvePart2(input) = count(isValidPart2, input)

@testset "Day 2" begin
    @test(solvePart1(input()) == 556)
    @test(solvePart2(input()) == 605)
end
