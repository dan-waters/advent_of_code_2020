require 'open-uri'

class AnswerReader
  def answers_from_file(filename)
    open(filename).read.split(/\n{2}/)
  end
end