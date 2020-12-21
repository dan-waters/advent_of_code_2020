require_relative 'instruction_reader'

instructions = InstructionReader.new.instructions_from_file('instructions.txt')

accumulator = 0
visited_lines = []

next_instruction = 0

until visited_lines.count(next_instruction) > 1 do
  instruction = instructions[next_instruction]
  visited_lines << next_instruction
  case instruction
  when /jmp (\+\d+|-\d+)/
    if visited_lines.include?(next_instruction + $~[1].to_i)
      puts next_instruction
      next_instruction += 1
    else
      next_instruction += $~[1].to_i
    end
  when /acc (\+\d+|-\d+)/
    accumulator += $~[1].to_i
    next_instruction += 1
  when /nop (\+\d+|-\d+)/
    next_instruction += 1
  when nil
    puts 'yay'
    break
  end
end

puts accumulator