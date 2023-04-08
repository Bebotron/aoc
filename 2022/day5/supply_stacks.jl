using DelimitedFiles

instructions = readlines(ARGS[1])

function separate_instructions(instructions)
    arrangement = Vector{String}(undef, 1)
    rearrangement = Vector{String}(undef, 1)
    for (line_num, line) in enumerate(instructions)
        if line == ""
            arrangement = instructions[1:line_num-1]
            rearrangement = instructions[line_num+1:end]
        end
    end
    return arrangement, rearrangement
end

arrangement, rearrangement = separate_instructions(instructions)
writedlm("arrangement.txt", arrangement)
writedlm("rearrangement.txt", rearrangement)
# arrangement = readdlm("arrangement.txt")
arrangement_strings = readlines("arrangement.txt")

function split_strings(input_strings)
    # find all non-space locations
    non_spaces = sort(union(findall.(!isspace, input_strings)...))
    # find initial indices of fields
    non_space_indices = non_spaces[vcat(1, findall(diff(non_spaces).!=1).+1)]
    # prepare ranges to extract fields
    non_space_ranges = [non_space_indices[i]:non_space_indices[i+1]-1 for i in 1:length(non_space_indices)-1]
    # extract substrings
    non_space_strings = map(s -> strip.(vcat([s[intersect(r,eachindex(s))] for r in non_space_ranges], non_space_indices[end] <= length(s) ? s[non_space_indices[end]:end] : "")), input_strings)
    # fit substrings into matrix
    L = maximum(length.(non_space_strings))
    String.([j <= length(non_space_strings[i]) ? non_space_strings[i][j] : "" 
      for i in eachindex(non_space_strings), j in 1:L])
end

arrangement = split_strings(arrangement_strings)
rearrangement = readdlm("rearrangement.txt")

stacks = [Vector{Any}(stack) for stack in eachcol(arrangement)]
pop!.(stacks)

function remove_empties(stack)
    if stack[1] == ""
        popfirst!(stack)
        remove_empties(stack)
    end
    return stack
end

remove_empties.(stacks)
num_to_move = rearrangement[:, 2]
from_stack = rearrangement[:, 4]
to_stack = rearrangement[:, 6]

for move in eachindex(num_to_move)
    for crate in 1:num_to_move[move]
        popped_crate = popfirst!(stacks[from_stack[move]])
        pushfirst!(stacks[to_stack[move]], popped_crate)
    end
end

display(stacks)
println()
println("*********** PART 2 ***********")

stacks = [Vector{Any}(stack) for stack in eachcol(arrangement)]
pop!.(stacks)
remove_empties.(stacks)

for move in eachindex(num_to_move)
    if num_to_move[move] == 1
        popped_crate = popfirst!(stacks[from_stack[move]])
        pushfirst!(stacks[to_stack[move]], popped_crate)
    else
        popped_crates = []
        for crates in 1:num_to_move[move]
            push!(popped_crates, popfirst!(stacks[from_stack[move]]))
        end
        stacks[to_stack[move]] = vcat(popped_crates, stacks[to_stack[move]])
    end
end

display(stacks)
println()
