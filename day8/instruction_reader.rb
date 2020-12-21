require 'open-uri'

class InstructionReader
  def instructions_from_file(filename)
    open(filename).readlines.map(&:strip)
  end
end