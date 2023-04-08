input = readline()

for (index, letter) in enumerate(input[14:end])
    marker = input[index:index+13]
    if length(keys(countmap([c for c in marker]))) == 14
        println(index + 13)
        return
    end
end