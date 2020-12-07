using Test

function input()
    io = open("2020/data/day_1.txt", "r")
    inputs = split(read(io, String), '\n', keepempty=false)
    return parse.(Int, inputs)
end

function solveForProduct(product)
    solution = Iterators.filter(
        ns -> sum(ns) == 2020,
        product
    ) |> first

    prod(solution)
end

function solvePart1(numbers)
    product = Iterators.product(numbers, numbers)
    solveForProduct(product)
end

function solvePart2(numbers)
    product = Iterators.product(numbers, numbers, numbers)
    solveForProduct(product)
end

@testset "Day 1" begin
    @test(solvePart1(input()) == 73371)
    @test(solvePart2(input()) == 127642310)
end
