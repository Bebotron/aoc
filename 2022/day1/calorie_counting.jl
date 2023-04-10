filepath = "./2022/day1/input.txt"
all_calories = readlines(filepath)
all_calories_array = [[]]
total_calories = []

global elf_index = 1
for calories in all_calories
    if calories != ""
        append!(all_calories_array[elf_index], parse(Int, calories))
    else
        append!(total_calories, sum(all_calories_array[elf_index]))
        append!(all_calories_array, [[]])
        global elf_index += 1
    end
end

println("Max calories :: ", findmax(total_calories))
println("Total Max 3 :: ", sum(reverse(sort(total_calories))[1:3]))
