get_input() = map(s -> parse(Int, s), readlines(joinpath(INPUT_DIR, "day01.txt")))

fuelForMass(mass::Int) = div(mass, 3) - 2

function solve(::Puzzle(2019, 1, 1), input)
    map(fuelForMass, get_input()) |> sum
end

recursiveFuel(mass::Int) = begin
    fuel = fuelForMass(mass)

    if fuel <= 0
        return 0
    end

    return fuel + recursiveFuel(fuel)
end

function solve(::Puzzle(2019, 1, 2), input)
    map(recursiveFuel, input) |> sum
end
