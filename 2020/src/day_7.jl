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

    filter(rule -> !isnothing(rule), rules)
end

function canContainShinyGold(rules, bag)
    if (!haskey(rules, bag))
        return false
    end

    if "shiny gold" in rules[bag]
        return true
    end

    return any(bag -> canContainShinyGold(rules, bag), rules[bag])
end


function solvePart1(input)
    rules = parseInput(input)
    bagRules = map(rules) do rule
        rule.bag => map(contain -> isnothing(contain) ? nothing : contain[2], rule.contains)
    end |> Dict

    return count(
        ((bag, contains),) -> canContainShinyGold(bagRules, bag),
        bagRules
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
    bagRules = map(
        rule -> rule.bag => map(contain -> contain, rule.contains),
        rules
    ) |> Dict

    amountOfBagsIn(bagRules, "shiny gold")
end

@testset "Day 7" begin
    @test(solvePart1(input()) == 144)
    @test(solvePart2(input()) == 5956)
end
