using AdventOfCodeSolutions
using Test

function input(puzzle::Puzzle{2, n}) where n
    io = openInput(puzzle)
    return split(read(io, String), '\n', keepempty=false)
end

function parsePassword(s)
    range, char, password = split(s, ' ')
    left, right = parse.(Int, split(range, '-'))

    return (left:right, char[1], password)
end

function isValidPart1(s)
    range, char, password = parsePassword(s)

    return count(==(char), password) in range
end

solve(::Puzzle{2, 1}, input) = count(isValidPart1, input)

function isValidPart2(s)
    range, char, password = parsePassword(s)

    return xor(
        password[range.start] == char,
        password[range.stop] == char
    )
end

solve(::Puzzle{2, 2}, input) = count(isValidPart2, input)

@testset "Day 2" begin
    @test(solve(Puzzle(2, 1), input(Puzzle(2, 1))) == 556)
    @test(solve(Puzzle(2, 2), input(Puzzle(2, 2))) == 605)
end
