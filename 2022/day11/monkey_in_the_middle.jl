using DelimitedFiles

notes = readdlm("2022/day11/input.txt", ':', String)
num_monkeys = Int(size(notes, 1)/6)
split_operations = split.(notes[3:6:size(notes, 1), 2], " new = ")
monkey_list = []
monkey_inspection_number = [0 for _ in 1:num_monkeys]

for monkey_index in 1:num_monkeys
    push!(monkey_list, parse.(Int, split(notes[2 + 6*(monkey_index - 1), 2], ",")))
end

total_rounds = 20
for round in 1:total_rounds
    for (monkey_index, monkey_items) in enumerate(monkey_list)
        monkey_inspection_number[monkey_index] += length(monkey_list[monkey_index])
        test_value = parse(Int, split(notes[4 + 6*(monkey_index - 1), 2], " ")[end])
        for (item_index, item) in enumerate(monkey_items)
            worry_level = item
            cleaned_operation_string = replace(split_operations[monkey_index][2], "old" => string(worry_level))
            worry_level = Int(floor(eval(Meta.parse(cleaned_operation_string))/3))
            if worry_level%test_value == 0
                new_monkey_index = parse(Int, notes[5 + 6*(monkey_index - 1), 2][end]) + 1
                push!(monkey_list[new_monkey_index], worry_level)
            else
                new_monkey_index = parse(Int, notes[6 + 6*(monkey_index - 1), 2][end]) + 1
                push!(monkey_list[new_monkey_index], worry_level)
            end
        end
        monkey_list[monkey_index] = Int[]
    end
end

println(monkey_list)
println(monkey_inspection_number)

monkey_business = prod((sort(monkey_inspection_number) |> reverse)[1:2])
println(monkey_business)

println("NO WORRY LEVEL REDUCTION")

new_monkey_list = []
new_monkey_inspection_number = [0 for _ in 1:num_monkeys]

relatively_prime_moduli = []

for monkey_index in 1:num_monkeys
    test_value = parse(Int, split(notes[4 + 6*(monkey_index - 1), 2], " ")[end])
    push!(relatively_prime_moduli, test_value)
end

moduli_product = prod(relatively_prime_moduli)
moduli_quotients = moduli_product ./ relatively_prime_moduli
multiplicative_factors = invmod.(Int.(moduli_quotients .% relatively_prime_moduli), relatively_prime_moduli)

for monkey_index in 1:num_monkeys
    items = parse.(Int, split(notes[2 + 6*(monkey_index - 1), 2], ","))
    items_tuples = []
    for item in items
        push!(items_tuples, item .% relatively_prime_moduli)
    end
    push!(new_monkey_list, items_tuples)
end

total_rounds = 10000
for round in 1:total_rounds
    for (monkey_index, monkey_items) in enumerate(new_monkey_list)
        new_monkey_inspection_number[monkey_index] += length(monkey_items)
        for (item_index, item) in enumerate(monkey_items)
            worry_level = item

            operation_elements = split(split_operations[monkey_index][2], " ")
            arithmetic_symbol = operation_elements[2]

            if operation_elements[3] == "old"
                operation_number = worry_level
            else
                operation_number = parse(Int, operation_elements[3])
            end
            
            arithmetic_vec = eval(Meta.parse(arithmetic_symbol)).(worry_level, operation_number) .% relatively_prime_moduli

            if arithmetic_vec[monkey_index] == 0
                new_monkey_index = parse(Int, notes[5 + 6*(monkey_index - 1), 2][end]) + 1
                push!(new_monkey_list[new_monkey_index], arithmetic_vec)
            else
                new_monkey_index = parse(Int, notes[6 + 6*(monkey_index - 1), 2][end]) + 1
                push!(new_monkey_list[new_monkey_index], arithmetic_vec)
            end
        end
        new_monkey_list[monkey_index] = []
    end
end

println(new_monkey_list)
println(new_monkey_inspection_number)

new_monkey_business = (new_monkey_inspection_number |> sort |> reverse)[1:2] |> prod
println(new_monkey_business)