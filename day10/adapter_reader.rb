require 'open-uri'
require_relative 'adapter'

class AdapterReader
  def adapters_from_file(filename)
    open(filename).readlines.map(&:strip).map { |rating| Adapter.new(rating) }
  end
end