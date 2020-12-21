require_relative 'cube_reader'

cubes = CubeReader.new.cubes_from_file('cubes.txt')

puts cubes
D = 4
Directions = [-1, 0, 1]
AllDirections = Directions.product(*Array.new(D - 1, Directions))

Cube = Struct.new(:x, :y, :z, :w) do
  def neighbours
    @neighbours ||= (AllDirections.map {|direction| offset_by(*direction)} - [self])
  end

  def offset_by(*directions)
    Cube.new(*values.zip(directions).map(&:sum))
  end
end

grid = Hash.new.tap{|grid| grid.default = '.'}

cubes.each_with_index do |line, y_index|
  line.chars.each_with_index do |value, x_index|
    grid[Cube.new(x_index, y_index, 0, 0)] = value
  end
end

6.times do
  changes = {}
  grid_and_neighbours = (grid.keys + grid.keys.flat_map(&:neighbours)).uniq

  grid_and_neighbours.each do |cube|
    active_neighbours = grid.values_at(*cube.neighbours).count('#')
    if grid[cube] == '#' && active_neighbours.between?(2, 3)
      next
    elsif grid[cube] == '.' && active_neighbours == 3
      changes[cube] = '#'
    else
      changes[cube] = '.'
    end
  end

  grid.merge!(changes)
end

puts grid.values.count('#')