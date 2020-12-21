require 'open-uri'

class DataReader
  def masks_from_file(filename)
    programs = open(filename).read.split(/mask = /).reject(&:empty?)
    programs.map do |program|
      lines = program.split(/\n/)
      mask = lines.shift
      allocations = lines.map do |line|
        match = line.match(/mem\[(\d+)\] = (\d+)/)
        address = match[1]
        value = match[2]
        {address: address.to_i, value: value.to_i}
      end
      {mask: mask, allocations: allocations}
    end
  end
end