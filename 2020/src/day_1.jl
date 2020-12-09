using AdventOfCodeSolutions
using Test

function input(puzzle::Puzzle{1, n}) where n
    io = openInput(puzzle)
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

function solve(::Puzzle{1, 1}, numbers)
    product = Iterators.product(numbers, numbers)
    solveForProduct(product)
end

function solve(::Puzzle{1, 2}, numbers)
    product = Iterators.product(numbers, numbers, numbers)
    solveForProduct(product)
end

@testset "Day 1" begin
    @test(solve(Puzzle(1, 1), input(Puzzle(1, 1))) == 73371)
    @test(solve(Puzzle(1, 2), input(Puzzle(1, 2))) == 127642310)
end
