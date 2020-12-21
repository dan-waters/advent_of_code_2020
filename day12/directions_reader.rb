require 'open-uri'

class DirectionsReader
  def directions_from_file(filename)
    open(filename).readlines.map(&:strip)
  end
end