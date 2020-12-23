cups = '459672813'.chars.map(&:to_i)

def crab_move(cups)
  first_cup = cups.shift
  next_three_cups = cups.shift(3)
  destination = cups.select{|x| x < first_cup}.max || cups.max
  cups.insert(cups.index(destination) + 1, *next_three_cups)
  cups << first_cup
end

100.times do
  cups = crab_move(cups)
end

index_1 = cups.index(1)
puts cups[index_1 + 1..cups.length] unless index_1 == cups.length
puts cups[0..index_1 - 1] unless index_1 == 0


# part 2, needs to be faster :(

cups = '459672813'.chars.map(&:to_i) + (10..1_000_000).to_a

Cup = Struct.new(:value, :right)

cup_map = {}
previous = nil

cups.each do |cup|
  entry = Cup.new(cup, previous)
  cup_map[cup] = entry
  if previous
    previous.right = entry
  end
  previous = entry
end

previous.right = cup_map[cups[0]]
current = nil

10_000_000.times do
  current = current ? current.right : cup_map[cups[0]]
  next_three_cups = [current.right, current.right.right, current.right.right.right]
  current.right = next_three_cups.last.right
  destination = current.value == 1 ? 1_000_000 : current.value - 1
  while next_three_cups.include?(cup_map[destination]) do
    destination = destination == 1 ? 1_000_000 : destination - 1
  end
  destination = cup_map[destination]
  next_three_cups.last.right = destination.right
  destination.right = next_three_cups.first
end

puts cup_map[1].right.value * cup_map[1].right.right.value