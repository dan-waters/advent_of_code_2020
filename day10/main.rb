require_relative 'adapter_reader'
require_relative 'adapter'


adapters = AdapterReader.new.adapters_from_file('adapters.txt').sort_by { |adapter| adapter.rating }

wall = Adapter.new(0)
device = Adapter.new(adapters.last.rating + 3)

adapters.prepend wall
adapters << device

one_jumps = []
three_jumps = []

adapters.each_with_index do |adapter, index|
  next_adapter = adapters[index + 1]
  if next_adapter
    difference = next_adapter.rating - adapter.rating
    if difference == 3
      three_jumps << next_adapter
    elsif difference == 1
      one_jumps << next_adapter
    end
  end
end

puts one_jumps

combos = one_jumps.slice_when do |i, j|
  !j.can_be_attached?(i)
end

groups_of_four = 0
groups_of_three = 0
groups_of_two = 0
groups_of_more = []

combos.each do |array_of_adapters|
  if array_of_adapters.length == 4
    groups_of_four +=1
  elsif array_of_adapters.length == 3
    groups_of_three +=1
  elsif array_of_adapters.length == 2
    groups_of_two +=1
  elsif array_of_adapters.length > 4
    groups_of_more << array_of_adapters
  end
end

puts groups_of_more

puts 2**groups_of_two * 4**groups_of_three * 7**groups_of_four