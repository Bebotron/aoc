using DelimitedFiles

program_instructions = readdlm("2022/day10/input.txt")
global register_X = 1
global cycle_number = 0
signal_cycles = [20, 60, 100, 140, 180, 220]
signal_strengths = Vector{Int}[]

for instruction in eachrow(program_instructions)
    global cycle_number += 1
    if cycle_number in signal_cycles
        push!(signal_strengths, [cycle_number*register_X])
    end
    if instruction[1] == "addx"
        global cycle_number += 1
        if cycle_number in signal_cycles
            push!(signal_strengths, [cycle_number*register_X])
        end
        global register_X += instruction[2]
    end
end

println("Signal strength sum :: ", sum(signal_strengths))

CRT = ['.' for _ in 1:40, _ in 1:6]

function print_CRT(CRT)
    for row in eachrow(CRT)
        for pixel in row
            print(pixel)
        end
        print('\n')
    end
end

global register_X = 1
global cycle_number = 0
pixel_line = [40, 80, 120, 160, 200, 240]
sprite_position = [1, 2, 3]

for instruction in eachrow(program_instructions)
    global cycle_number += 1
    if (cycle_number + 39)%40 + 1 in sprite_position
        CRT[cycle_number] = '#'
    end
    if instruction[1] == "addx"
        global cycle_number += 1
        if (cycle_number + 39)%40 + 1 in sprite_position
            CRT[cycle_number] = '#'
        end
        global sprite_position .+= instruction[2]
    end
end

print_CRT(permutedims(CRT))