require_relative 'data_reader'

programs = DataReader.new.masks_from_file('inputs.txt')

puts programs

mem = []

programs.each do |program|
  mask = program[:mask]
  program[:allocations].each do |alloc|
    binary_value = alloc[:value].to_s(2).rjust(mask.length, '0').chars
    mask.chars.each_with_index do |char, index|
      binary_value[index] = char unless char == 'X'
    end
    mem[alloc[:address]] = binary_value.join.to_i(2)
  end
end

puts mem.compact.sum

mem2 = {}

programs.each do |program|
  mask = program[:mask]
  program[:allocations].each do |alloc|
    binary_address = alloc[:address].to_s(2).rjust(mask.length, '0').chars
    mask.chars.each_with_index do |char, index|
      binary_address[index] = char unless char == '0'
    end
    address_to_write = [binary_address]
    while address =  address_to_write.detect { |a| a.include?('X') } do
      address_to_write.delete(address)
      x_index = address.index('X')
      address[x_index] = '0'
      address_to_write << address.dup
      address[x_index] = '1'
      address_to_write << address.dup
    end

    address_to_write.each do |address|
      mem2[address.join.to_i(2)] = alloc[:value]
    end
  end
end

puts mem2.values.sum