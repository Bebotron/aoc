tree_map_input = readlines(ARGS[1])
tree_map = zeros(Int, length(tree_map_input), length(tree_map_input[1]))

for (row_index, row) in enumerate(tree_map_input)
    for (col_index, tree_height) in enumerate(row)
        tree_map[row_index, col_index] = parse(Int, tree_height)
    end
end

num_visible_trees = 2*size(tree_map, 1) + 2*(size(tree_map, 2) - 2)

for row_index in 2:size(tree_map, 1)-1
    for col_index in 2:size(tree_map, 2)-1
        taller_than_row_left = tree_map[row_index, col_index] .> tree_map[row_index, 1:col_index-1]
        taller_than_row_right = tree_map[row_index, col_index] .> tree_map[row_index, col_index+1:end]
        taller_than_col_top = tree_map[row_index, col_index] .> tree_map[1:row_index-1, col_index]
        taller_than_col_bottom = tree_map[row_index, col_index] .> tree_map[row_index+1:end, col_index]

        is_visible_from_left = !(0 in taller_than_row_left)
        is_visible_from_right = !(0 in taller_than_row_right)
        is_visible_from_top = !(0 in taller_than_col_top)
        is_visible_from_bottom = !(0 in taller_than_col_bottom)

        if is_visible_from_left || is_visible_from_right || is_visible_from_top || is_visible_from_bottom
            global num_visible_trees += 1
        end
    end
end

println(num_visible_trees)

scenic_score = ones(Int, size(tree_map))

for row_index in 2:size(tree_map, 1)-1
    for col_index in 2:size(tree_map, 2)-1
        
        taller_than_row_left = tree_map[row_index, col_index] .<= tree_map[row_index, 1:col_index-1]
        taller_than_row_right = tree_map[row_index, col_index] .<= tree_map[row_index, col_index+1:end]
        taller_than_col_top = tree_map[row_index, col_index] .<= tree_map[1:row_index-1, col_index]
        taller_than_col_bottom = tree_map[row_index, col_index] .<= tree_map[row_index+1:end, col_index]

        scenic_score_left = 0
        scenic_score_right = 0
        scenic_score_top = 0
        scenic_score_bottom = 0

        for is_taller in Iterators.reverse(taller_than_row_left)
            if is_taller
                scenic_score_left += 1
                break
            else
                scenic_score_left += 1
            end
        end
        for is_taller in taller_than_row_right
            if is_taller
                scenic_score_right += 1
                break
            else
                scenic_score_right += 1
            end
        end
        for is_taller in Iterators.reverse(taller_than_col_top)
            if is_taller
                scenic_score_top += 1
                break
            else
                scenic_score_top += 1
            end
        end
        for is_taller in taller_than_col_bottom
            if is_taller
                scenic_score_bottom += 1
                break
            else
                scenic_score_bottom += 1
            end
        end

        scenic_score[row_index, col_index] *= scenic_score_left*scenic_score_right*scenic_score_top*scenic_score_bottom
    end
end

println(findmax(scenic_score))

