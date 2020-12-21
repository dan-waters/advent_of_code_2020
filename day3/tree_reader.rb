require 'open-uri'

class TreeReader
  def trees_from_file(filename)
    open(filename).readlines.map(&:strip)
  end
end