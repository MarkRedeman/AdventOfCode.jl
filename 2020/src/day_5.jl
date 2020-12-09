using AdventOfCodeSolutions
using Test

function input(puzzle::Puzzle{2020, 5, n}) where n
    io = openInput(puzzle)
    split(read(io, String), "\n", keepempty=false)
end

seatRow(str) = map(s -> s == 'F' ? 0 : 1, collect(str[1:7]))
seatColumn(str) = map(s -> s == 'L' ? 0 : 1, collect(str[8:end]))
parseSeat(str) = parse(Int, join(str), base=2)

function decode(str)
    row = seatRow(str) |> parseSeat
    column = seatColumn(str) |> parseSeat
    return (row = row, column = column)
end

seatId(str::AbstractString) = seatId(decode(str)...)
seatId(row, column) = 8 * row + column
seatId(seat) = seatId(seat...)

solve(::Puzzle{2020, 5, 1}, input) = max(seatId.(input)...)


notVeryFrontOrBack((row, column),) = row != 0 && row != 127
hasGap((left, right),) = left == right - 2

AdjacentElements(c) = Iterators.zip(c, Iterators.drop(c, 1))

function solve(::Puzzle{2020, 5, 2}, input)
    seats = decode.(input)
    takenSeats = seatId.(filter(notVeryFrontOrBack, seats)) |> sort

    (left, right) = Iterators.filter(hasGap, AdjacentElements(takenSeats)) |> first
    return left + 1
end

@testset "Day 5" begin
    @test(seatId("BFFFBBFRRR") == 567)
    @test(seatId("FFFBBBFRRR") == 119)
    @test(seatId("BBFFBBFRLL") == 820)
    @test(solve(Puzzle(5, 1), input(Puzzle(5, 1))) == 894)
    @test(solve(Puzzle(5, 2), input(Puzzle(5, 2))) == 579)
end
