require 'open-uri'

tiles = open('tiles.txt').readlines(chomp: true)

instructions = tiles.map(&:chars).map do |chars|
  instruction = []
  while chars.any? do
    case chars.first
    when /[ew]/
      instruction << chars.shift
    when /[ns]/
      instruction << (chars.shift + chars.shift)
    end
  end
  instruction
end

TilePosition = Struct.new(:x, :y) do
  def move!(direction)
    case direction
    when 'ne'
      self.x += 1
      self.y += 1
    when 'se'
      self.x += 1
      self.y -= 1
    when 'nw'
      self.x -= 1
      self.y += 1
    when 'sw'
      self.x -= 1
      self.y -= 1
    when 'e'
      self.x += 2
    when 'w'
      self.x -= 2
    end
    self
  end

  def neighbours
    [
        TilePosition.new(self.x, self.y).move!('e'),
        TilePosition.new(self.x, self.y).move!('se'),
        TilePosition.new(self.x, self.y).move!('sw'),
        TilePosition.new(self.x, self.y).move!('w'),
        TilePosition.new(self.x, self.y).move!('nw'),
        TilePosition.new(self.x, self.y).move!('ne')
    ]
  end
end

tiles = {}

instructions.each do |instruction|
  tp = TilePosition.new(0, 0)
  instruction.each do |move|
    tp.move!(move)
  end
  tiles[tp] = tiles[tp] ? !tiles[tp] : true
end

puts tiles.values.select { |x| x }.count

100.times do
  tiles.keys.each do |tp|
    tp.neighbours.each do |n|
      tiles[n] = tiles[n] || false
    end
  end

  changes = {}
  tiles.keys.each do |tp|
    if tiles[tp] # black
      black_neighbour_count = tp.neighbours.select { |neighbour| tiles[neighbour] == true }.count
      if black_neighbour_count == 0 || black_neighbour_count > 2
        changes[tp] = false
      end
    elsif tiles[tp] == false # white
      black_neighbour_count = tp.neighbours.select { |neighbour| tiles[neighbour] == true }.count
      if black_neighbour_count == 2
        changes[tp] = true
      end
    end
  end
  tiles.merge!(changes)
end

puts tiles.values.select { |x| x }.count