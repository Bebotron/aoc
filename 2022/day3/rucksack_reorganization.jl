# rucksacks = readlines(ARGS[1])
rucksacks = readlines("2022/day3/input.txt")
first_compartments = similar(rucksacks)
second_compartments = similar(rucksacks)
common_items = Array{Char}(undef, length(rucksacks))
item_value = Array{Int}(undef, length(rucksacks))

for (index, rucksack) in enumerate(rucksacks)
    first_compartments[index] = rucksack[1:Int(length(rucksack)/2)]
    second_compartments[index] = rucksack[Int(length(rucksack)/2) + 1:end]
    for item1 in first_compartments[index]
        for item2 in second_compartments[index]
            if item1 == item2
                item_value[index] = islowercase(item1) ? Int8(item1) - Int8('a') + 1 : Int8(item1) - Int8('A') + 27
                common_items[index] = item1
            end
        end
    end
end

println(sum(item_value))

function find_common_item(group_rucksack)
    for item1 in group_rucksack[1]
        for item2 in group_rucksack[2]
            for item3 in group_rucksack[3]
                if item1 == item2 == item3
                    return item1
                end
            end
        end
    end
end

num_groups = Int(length(rucksacks)/3)
group_item_value = Array{Int}(undef, num_groups)
for group_number in 1:num_groups
    index = 4%3 + 3*(group_number - 1)
    group_item = find_common_item(rucksacks[index:index + 2])
    group_item_value[group_number] = islowercase(group_item) ? Int8(group_item) - Int8('a') + 1 : Int8(group_item) - Int8('A') + 27
end

println(sum(group_item_value))