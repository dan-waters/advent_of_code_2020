require_relative 'directions_reader'

directions = DirectionsReader.new.directions_from_file('directions.txt')

cardinals = ['N', 'E', 'S', 'W']

waypoint_position_north = 1
waypoint_position_east = 10

ship_position_north = 0
ship_position_east = 0

directions.each do |direction|
  case direction
  when /F(\d+)/
    times = $~[1].to_i
    ship_position_north += times * waypoint_position_north
    ship_position_east += times * waypoint_position_east
  when /N(\d+)/
    waypoint_position_north += $~[1].to_i
  when /S(\d+)/
    waypoint_position_north -= $~[1].to_i
  when /E(\d+)/
    waypoint_position_east += $~[1].to_i
  when /W(\d+)/
    waypoint_position_east -= $~[1].to_i
  when /R(\d+)/
    turn = ($~[1].to_i) / 90
    turn.times do
      new_north = -waypoint_position_east
      waypoint_position_east = waypoint_position_north
      waypoint_position_north = new_north
    end
  when /L(\d+)/
    turn = ($~[1].to_i) / 90
    turn.times do
      new_east = -waypoint_position_north
      waypoint_position_north = waypoint_position_east
      waypoint_position_east = new_east
    end
  end
end

puts ship_position_north - ship_position_east