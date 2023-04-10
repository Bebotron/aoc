using DelimitedFiles
strategy_guide = readdlm("2022/day2/input.txt")

win_dictionary = Dict("A" => "Y", "B" => "Z", "C" => "X")
draw_dictionary = Dict("A" => "X", "B" => "Y", "C" => "Z")
lose_dictionary = Dict("A" => "Z", "B" => "X", "C" => "Y")
shape_value = Dict("X" => 1, "Y" => 2, "Z" => 3)
outcome_value = Dict("L" => 0, "D" => 3, "W" => 6)

outcome_array = Vector(undef, size(strategy_guide, 1))
for (index, recommendation) in enumerate(eachrow(strategy_guide))
    if recommendation[2] == win_dictionary[recommendation[1]]
        outcome_array[index] = "W"
    elseif recommendation[2] == draw_dictionary[recommendation[1]]
        outcome_array[index] = "D"
    else
        outcome_array[index] = "L"
    end
end

total_outcome_value = sum(get.(Ref(outcome_value), outcome_array, missing))
total_shape_value = sum(get.(Ref(shape_value), strategy_guide[:, 2], missing))

println("Assumed total points :: ", total_outcome_value + total_shape_value)

needed_dictionary = Dict("X" => "L", "Y" => "D", "Z" => "W")
updated_outcome_array = get.(Ref(needed_dictionary), strategy_guide[:, 2], missing)
updated_outcome_value = sum(get.(Ref(outcome_value), updated_outcome_array, missing))

shape_array = Vector(undef, size(strategy_guide, 1))
for (index, recommendation) in enumerate(eachrow(strategy_guide))
    if updated_outcome_array[index] == "W"
        shape_array[index] = win_dictionary[recommendation[1]]
    elseif updated_outcome_array[index] == "D"
        shape_array[index] = draw_dictionary[recommendation[1]]
    else
        shape_array[index] = lose_dictionary[recommendation[1]]
    end
end

updated_shape_value = sum(get.(Ref(shape_value), shape_array, missing))

println("Actual total points :: ", updated_outcome_value + updated_shape_value)
