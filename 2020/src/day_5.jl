using Test;

function input()
    io = open("2020/data/day_5.txt", "r")
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

solvePart1(input) = max(seatId.(input)...)


notVeryFrontOrBack((row, column),) = row != 0 && row != 127
hasGap((left, right),) = left == right - 2

AdjacentElements(c) = Iterators.zip(c, Iterators.drop(c, 1))

function solvePart2(input)
    seats = decode.(input)
    takenSeats = seatId.(filter(notVeryFrontOrBack, seats)) |> sort

    (left, right) = Iterators.filter(hasGap, AdjacentElements(takenSeats)) |> first
    return left + 1
end

@testset "Day 5" begin
    @test(seatId("BFFFBBFRRR") == 567)
    @test(seatId("FFFBBBFRRR") == 119)
    @test(seatId("BBFFBBFRLL") == 820)
    @test(solvePart1(input()) == 894)
    @test(solvePart2(input()) == 579)
end
