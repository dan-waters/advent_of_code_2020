require 'open-uri'

class CubeReader
  def cubes_from_file(filename)
    cubes = open(filename).readlines(chomp: true)
  end
end