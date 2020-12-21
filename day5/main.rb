require_relative 'seat_reader'

seats = SeatReader.new.seats_from_file('seats.txt')

puts seats.
    sort_by { |seat| seat.seat_id }.
    group_by { |seat| seat.row }.
    select { |row, group| group.count < 8 }.
    map { |row, group| group }.flatten