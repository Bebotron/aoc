using StatsBase

input = readline("2022/day6/input.txt")

for (index, letter) in enumerate(input[4:end])
    marker = input[index:index+3]
    if length(keys(countmap([c for c in marker]))) == 4
        println(index + 3)
        return
    end
end

for (index, letter) in enumerate(input[14:end])
    marker = input[index:index+13]
    if length(keys(countmap([c for c in marker]))) == 14
        println(index + 13)
        return
    end
end