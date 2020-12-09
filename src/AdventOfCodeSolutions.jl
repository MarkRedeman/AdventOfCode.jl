module AdventOfCodeSolutions

struct Puzzle{day, part} end
Puzzle(day, part) = Puzzle{day, part}()

function openInput(::Puzzle{d, p}) where {d, p}
    return open(joinpath(@__DIR__, "../2020/data/day_$d.txt"), "r")
end

export Puzzle, openInput
end
