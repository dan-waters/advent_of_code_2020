require_relative 'answer_reader'

answer_groups = AnswerReader.new.answers_from_file('answers.txt')

puts (answer_groups.map do |answers|
  answers.gsub(/\s/, '').chars.uniq.count
end.sum)


puts (answer_groups.map do |answers|
  answers.split(/\n/).map{|x| x.chars}.inject(:&).count
end.sum)