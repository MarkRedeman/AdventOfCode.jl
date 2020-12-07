# https://adventofcode.com/2020/day/7
using AdventOfCode

function input()
    io = open("2020/data/day_7.txt", "r")
    split(read(io, String), "\n", keepempty=false)
end

function parseInput(input)
    rules = map(input) do rule
        (bag, containRules) = split(rule, " bags contain ")
        contains = map(split(containRules, ", ")) do rule
            m = match(r"^(\d+) (.*) bags?.?$", rule)

            if (isnothing(m))
                return nothing
            end

            return (parse(Int, m.captures[1]), string(m.captures[2]))
        end


        return (
            bag = bag,
            contains = filter(!isnothing, contains)
        )
    end

    return map(rule -> rule.bag => rule.contains, rules) |> Dict
end

function canContainShinyGold(rules, bag)
    if (!haskey(rules, bag))
        return false
    end
    # @show rules[bag]

    if "shiny gold" in last.(rules[bag])
        return true
    end

    return any(bag -> canContainShinyGold(rules, last(bag)), rules[bag])
end


function solvePart1(input)
    rules = parseInput(input)

    return count(
        ((bag, contains),) -> canContainShinyGold(rules, bag),
        rules
    )
end


function amountOfBagsIn(rules, bag)
    bags = rules[bag]

    if (length(bags) == 0)
        return 0
    end

    map(
        ((amount, name),) -> amount * (1 + amountOfBagsIn(rules, name)),
        bags
    ) |> sum
end

function solvePart2(input)
    rules = parseInput(input)
    amountOfBagsIn(rules, "shiny gold")
end

@testset "Day 7" begin
    @test(solvePart1(input()) == 144)
    @test(solvePart2(input()) == 5956)
end
