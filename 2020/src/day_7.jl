using AdventOfCodeSolutions
using Test

function input(puzzle::Puzzle{2020, 7, n}) where n
    io = openInput(puzzle)
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


function solve(::Puzzle{2020, 7, 1}, input)
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

function solve(::Puzzle{2020, 7, 2}, input)
    rules = parseInput(input)
    amountOfBagsIn(rules, "shiny gold")
end

@testset "Day 7" begin
TEST_INPUT = split("""
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.
""", '\n', keepempty=false)
    @test(solve(Puzzle(7, 1), TEST_INPUT) == 4)
    @test(solve(Puzzle(7, 1), input(Puzzle(7, 1))) == 144)

TEST_INPUT_2 = split("""
shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags.
""", '\n', keepempty=false)
    @test(solve(Puzzle(7, 2), TEST_INPUT_2) == 126)
    @test(solve(Puzzle(7, 2), input(Puzzle(7, 2))) == 5956)
end
