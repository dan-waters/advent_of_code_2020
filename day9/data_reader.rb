require 'open-uri'

class DataReader
  def data_from_file(filename)
    open(filename).readlines.map(&:strip).map(&:to_i)
  end
end