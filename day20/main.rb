require 'open-uri'

Tile = Struct.new(:number, :pattern) do
  def lines
    pattern.split("\n")
  end

  def columns
    (0..width - 1).map do |column|
      lines.map { |line| line[column] }.join
    end
  end

  def width
    lines.first.length
  end

  def height
    lines.length
  end

  def border
    [top, right, bottom, left]
  end

  def top
    lines.first
  end

  def bottom
    lines.last
  end

  def right
    columns.last
  end

  def left
    columns.first
  end

  def flip_vertical!
    self.pattern = lines.reverse.join("\n")
  end

  def flip_horizontal!
    self.pattern = lines.map(&:reverse).join("\n")
  end

  def rotate!
    self.pattern = columns.map(&:reverse).join("\n")
  end

  def hash
    number.hash
  end

  def inner_pattern
    lines[1..-2].map do |line|
      line[1..-2]
    end
  end
end

tiles = open('tiles.txt').read.split("\n\n").map do |tile|
  number = tile.scan(/\d+/).first.to_i
  pattern = tile.split(":\n").last
  Tile.new(number, pattern)
end

neighbours = {}

tiles.select do |tile|
  neighbours[tile] = (tiles - [tile]).select do |potential_neighbour|
    potential_neighbour.border.any? do |border_edge|
      tile.border.include?(border_edge) || tile.border.include?(border_edge.reverse)
    end
  end
end

corner_tiles = neighbours.select { |k, v| v.count == 2 }.map(&:first)

if corner_tiles.count == 4
  puts corner_tiles.map(&:number).inject(:*)
else
  puts "try again!"
end

GridPosition = Struct.new(:x, :y)
@grid = {}
@neighbours = neighbours

def place_neighbours(tile)
  position = @grid.key(tile)
  @neighbours[tile].each do |neighbour|
    next if @grid.values.include? neighbour
    n_position = nil
    while n_position.nil? do
      if neighbour.left == tile.right
        n_position = GridPosition.new(position.x + 1, position.y)
      elsif neighbour.right == tile.left
        n_position = GridPosition.new(position.x - 1, position.y)
      elsif neighbour.top == tile.bottom
        n_position = GridPosition.new(position.x, position.y + 1)
      elsif neighbour.bottom == tile.top
        n_position = GridPosition.new(position.x, position.y - 1)
      elsif neighbour.left.reverse == tile.right || neighbour.right.reverse == tile.left
        neighbour.flip_vertical!
      elsif neighbour.top.reverse == tile.bottom || neighbour.bottom.reverse == tile.top
        neighbour.flip_horizontal!
      else
        neighbour.rotate!
      end
    end
    @grid[n_position] = neighbour
  end
end

corner = corner_tiles.first
position = GridPosition.new(0, 0)
@grid[position] = corner

while @grid.values.count < 144 do
  next_tile = @grid.values.detect do |tile|
    (neighbours[tile] - @grid.values).any?
  end
  place_neighbours(next_tile)
end

image = {}

@grid.each do |k, v|
  image[k] = v.inner_pattern
end

full_string = []

(0..11).each do |y|
  (0..11).each do |x|
    (0..7).each do |line|
      if full_string[line + 8*y]
        full_string[line + 8*y] += image[GridPosition.new(x, y)][line]
      else
        full_string[line + 8*y] = image[GridPosition.new(x, y)][line]
      end
    end
  end
end

full_tile = Tile.new(1_000_000, full_string.join("\n"))
head = '#[.#]'
body = '#....##....##....###'
belly = '[.#]#..#..#..#..#..#'
sea = '.{77}'
sea_monster = /(?=(#{head}#{sea}#{body}#{sea}#{belly}))/m
sea_count = 0

sea_count += full_tile.pattern.scan(sea_monster).count
puts "Seamonsters: #{full_tile.pattern.scan(sea_monster).count}"
full_tile.rotate!
sea_count += full_tile.pattern.scan(sea_monster).count
puts "Seamonsters: #{full_tile.pattern.scan(sea_monster).count}"
full_tile.rotate!
sea_count += full_tile.pattern.scan(sea_monster).count
puts "Seamonsters: #{full_tile.pattern.scan(sea_monster).count}"
full_tile.rotate!
sea_count += full_tile.pattern.scan(sea_monster).count
puts "Seamonsters: #{full_tile.pattern.scan(sea_monster).count}"
full_tile.flip_vertical!
sea_count += full_tile.pattern.scan(sea_monster).count
puts "Seamonsters: #{full_tile.pattern.scan(sea_monster).count}"
full_tile.rotate!
sea_count += full_tile.pattern.scan(sea_monster).count
puts "Seamonsters: #{full_tile.pattern.scan(sea_monster).count}"
full_tile.rotate!
sea_count += full_tile.pattern.scan(sea_monster).count
puts "Seamonsters: #{full_tile.pattern.scan(sea_monster).count}"
full_tile.rotate!
sea_count += full_tile.pattern.scan(sea_monster).count
puts "Seamonsters: #{full_tile.pattern.scan(sea_monster).count}"

puts "#{full_tile.pattern.count('#') - sea_count*15} is the total roughness"