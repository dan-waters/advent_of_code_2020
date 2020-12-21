require 'open-uri'
require_relative 'seat_layout'

class SeatReader
  def seats_from_file(filename)
    SeatLayout.new(open(filename).readlines.map(&:strip).map(&:chars))
  end
end