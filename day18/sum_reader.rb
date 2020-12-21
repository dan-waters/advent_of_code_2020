require 'open-uri'

class SumReader
  def sums_from_file(filename)
    open(filename).readlines(chomp: true)
  end
end