require_relative 'seat_reader'
require_relative 'seat_layout'

seat_layout = SeatReader.new.seats_from_file('seats.txt')

while seat_layout.shift! do
  puts 'retrying'
end

puts seat_layout.to_s
puts seat_layout.occupied_count
