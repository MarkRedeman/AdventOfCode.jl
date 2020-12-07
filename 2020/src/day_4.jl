function input()
    io = open("2020/data/day_4.txt", "r")
    passports = split(read(io, String), "\n\n", keepempty=false)
    # Map passports to an array of fields where each field is given by a type and value
    map(passport -> split.(split(passport, r"\n| ", keepempty=false), ':'), passports)
end

struct PassportField{field}
    value::AbstractString
end

function parsePassword(s)
    range, char, password = split(s, ' ')
    left, right = parse.(Int, split(range, '-'))

    return (left:right, char[1], password)
end

function passpordIsValid1(passpord)
    return length(filter(x -> x[1] != "cid", passpord)) == 7
end

function solvePart1(input)
    credentials = input
    return filter(passpordIsValid1, credentials) |> length
end

isValid(x, y) = false
function isValid(::Val{:byr}, input)
    byr = parse(Int, input)
    if (! (byr in 1920:2002))
        return false
    end
    return true
end

function passpordIsValid2(passpord)
    fp = filter(x -> x[1] != "cid", passpord)
    if (length(fp) != 7)
        return false
    end
    p = Dict(fp);

    if (! isValidByr(parse(Int, p["byr"])))
        return false
    end

    if (! isValidIyr(parse(Int, p["iyr"])))
        return false
    end

    if (! isValidEyr(parse(Int, p["eyr"])))
        return false
    end

    if (! isValidHeight(p["hgt"]))
        return false
    end

    if (! isValidHcl(p["hcl"]))
        return false
    end

    if (! isValidEcl(p["ecl"]))
        return false
    end

    if (! isValidPid(p["pid"]))
       return false
    end

    return true
end

isValidByr(byr) = 1920 <= byr <= 2002
isValidIyr(iyr) = 2010 <= iyr <= 2020
isValidEyr(eyr) = 2020 <= eyr <= 2030

function isValidHeight(hgt)
    m = match(r"^(\d.*)(cm|in)$", hgt)

    if (isnothing(m))
        return false
    end

    unit = m.captures[2]
    height = parse(Int, m[1])

    if (unit == "cm")
        return 150 <= height <= 193
    elseif (unit == "in")
        return 59 <= height <= 76
    end

    return false
end


isValidEcl(ecl) = ecl in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
isValidHcl(hcl) = occursin(r"\#[0-9a-f]{6}", hcl)

function isValidPid(pid)
    try
        pidi = parse(Int, pid)
        # @show pidi, length(p["pid"]), p["pid"]
        if (length(pid) != 9)
            # @show p["pid"]
            return false
        end
    catch e
        return false
    end
    return true
end

function solvePart2(input)
    credentials = input
    return  filter(passpordIsValid2, credentials) |> length
end

@testset "Day 4" begin
    @test(solvePart1(input()) == 242)
    @test(solvePart2(input()) == 186)
end
