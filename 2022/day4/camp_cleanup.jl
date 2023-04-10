using DelimitedFiles

section_assignments = replace.(readdlm("2022/day4/input.txt", ','), '-' => ':')
section_ranges = Meta.parse.(section_assignments)

count = 0

for pair in eachrow(section_ranges)
    if issubset(eval(pair[1]), eval(pair[2])) || issubset(eval(pair[2]), eval(pair[1]))
        global count += 1
    end
end

println(count)

count = 0

for pair in eachrow(section_ranges)
    if !isdisjoint(eval(pair[1]), eval(pair[2]))
        global count += 1
    end
end

println(count)