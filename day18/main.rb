require_relative 'sum_reader'

def calculate(sum_fragment)
  total = 0
  method = :+
  while sum_fragment.any? do
    char = sum_fragment.shift
    case char
    when /(\d+)/
      total = total.send(method, $~[1].to_i)
    when /\+/
      method = :+
    when /\*/
      method = :*
    when /\(/
      total = total.send(method, calculate(sum_fragment))
    when /\)/
      return total
    end
  end
  total
end

puts SumReader.new.sums_from_file('sums.txt').map(&:chars).map { |sum| calculate(sum) }.sum

def recalculate(sum_fragment)
  eval((sum_fragment).gsub('*', '#').gsub('+', '*').gsub('#', '+'))
end

class Integer
  alias_method :new_add, :+
  alias_method :+, :*
  alias_method :*, :new_add
end

puts SumReader.new.sums_from_file('sums.txt').map { |sum| recalculate(sum) }.sum