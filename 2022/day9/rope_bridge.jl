using DelimitedFiles

head_movements = readdlm("2022/day9/input.txt")

current_head_position = [1, 1]
current_tail_position = [1, 1]
visited_indices = [(1, 1)]

for (index, movement) in enumerate(eachrow(head_movements))
    if movement[1] == "R"
        for step in 1:movement[2]
            current_head_position[1] += 1
            distance = sqrt((current_head_position[1] - current_tail_position[1])^2 + (current_head_position[2] - current_tail_position[2])^2)
            if distance == 2
                current_tail_position[1] += 1
            elseif distance == sqrt(5)
                current_tail_position[2] = current_head_position[2]
                current_tail_position[1] += 1
            end
            if !(Tuple(current_tail_position) in visited_indices)
                append!(visited_indices, [Tuple(current_tail_position)])
            end
        end
    elseif movement[1] == "L"
        for step in 1:movement[2]
            current_head_position[1] -= 1
            distance = sqrt((current_head_position[1] - current_tail_position[1])^2 + (current_head_position[2] - current_tail_position[2])^2)
            if distance == 2
                current_tail_position[1] -= 1
            elseif distance == sqrt(5)
                current_tail_position[2] = current_head_position[2]
                current_tail_position[1] -= 1
            end
            if !(Tuple(current_tail_position) in visited_indices)
                append!(visited_indices, [Tuple(current_tail_position)])
            end
        end
    elseif movement[1] == "U"
        for step in 1:movement[2]
            current_head_position[2] += 1
            distance = sqrt((current_head_position[1] - current_tail_position[1])^2 + (current_head_position[2] - current_tail_position[2])^2)
            if distance == 2
                current_tail_position[2] += 1
            elseif distance == sqrt(5)
                current_tail_position[1] = current_head_position[1]
                current_tail_position[2] += 1
            end
            if !(Tuple(current_tail_position) in visited_indices)
                append!(visited_indices, [Tuple(current_tail_position)])
            end
        end
    elseif movement[1] == "D"
        for step in 1:movement[2]
            current_head_position[2] -= 1
            distance = sqrt((current_head_position[1] - current_tail_position[1])^2 + (current_head_position[2] - current_tail_position[2])^2)
            if distance == 2
                current_tail_position[2] -= 1
            elseif distance == sqrt(5)
                current_tail_position[1] = current_head_position[1]
                current_tail_position[2] -= 1
            end
            if !(Tuple(current_tail_position) in visited_indices)
                append!(visited_indices, [Tuple(current_tail_position)])
            end
        end
    end
end

println("Number of visited sites :: ", length(visited_indices))

ten_knot_positions = [[1, 1] for knot_number in 1:10]
knot_10_visited_sites = [(1, 1)]

for movement in eachrow(head_movements)
    for step in 1:movement[2]
        if movement[1] == "R"
            ten_knot_positions[1][1] += 1
        elseif movement[1] == "L"
            ten_knot_positions[1][1] -= 1
        elseif movement[1] == "U"
            ten_knot_positions[1][2] += 1
        else
            ten_knot_positions[1][2] -= 1
        end
        for knot_number in 2:10
            x_difference = ten_knot_positions[knot_number - 1][1] - ten_knot_positions[knot_number][1]
            y_difference = ten_knot_positions[knot_number - 1][2] - ten_knot_positions[knot_number][2]
            distance = sqrt((x_difference)^2 + (y_difference)^2)
            if distance in (2, sqrt(5), sqrt(8))
                ten_knot_positions[knot_number][1] += x_difference != 0 ? x_difference/abs(x_difference) : 0
                ten_knot_positions[knot_number][2] += y_difference != 0 ? y_difference/abs(y_difference) : 0
            end
        end
        if !(Tuple(ten_knot_positions[10]) in knot_10_visited_sites)
            append!(knot_10_visited_sites, [Tuple(ten_knot_positions[10])])
        end
    end
end

println("Number of sites last knot visited :: ", length(knot_10_visited_sites))