all_commands = readlines("2022/day7/input.txt")
directory_size_list = [0]
popfirst!(all_commands)

for command in all_commands
    if issubset("dir ", command)
        append!(directory_size_list, 0)
    end
end

command_index = 1
global_directory_index = 1

function get_directory_size(directory_index)
    directory_size = 0
    while command_index <= length(all_commands)
        command = all_commands[command_index]
        global command_index += 1
        if issubset("\$ ", command)
            if issubset("\$ cd", command)
                if command == "\$ cd .."
                    directory_size_list[directory_index] += directory_size
                    return directory_size
                else
                    global global_directory_index += 1
                    directory_size += get_directory_size(global_directory_index)
                end
            end
        elseif !issubset("dir ", command)
            directory_size += parse(Int, filter(isdigit, command))
        end
    end
    directory_size_list[directory_index] += directory_size
    return directory_size
end

get_directory_size(1)

println(sum([dir_size < 100000 ? dir_size : 0 for dir_size in directory_size_list]))

filesystem_size = 70000000
needed_space = 30000000

smallest_required = needed_space - (filesystem_size - directory_size_list[1])

differences = directory_size_list .- smallest_required

smallest_diff = findmin(filter(diff -> diff > 0, differences))
required_directory = directory_size_list[indexin(smallest_diff[1], differences)]

println(required_directory)