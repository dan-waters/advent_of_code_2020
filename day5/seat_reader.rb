require 'open-uri'
require_relative 'seat'

class SeatReader
  def seats_from_file(filename)
    open(filename).readlines.map do |seat|
      Seat.new(seat)
    end
  end
end