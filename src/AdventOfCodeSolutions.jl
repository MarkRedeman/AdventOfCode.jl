module AdventOfCodeSolutions

struct Puzzle{year, day, part} end
Puzzle(day, part) = Puzzle{2020, day, part}()
Puzzle(year, day, part) = Puzzle{year, day, part}()

function openInput(::Puzzle{2020, d, p}) where {d, p}
    return open(joinpath(@__DIR__, "../2020/data/day_$d.txt"), "r")
end

export Puzzle, openInput
end
