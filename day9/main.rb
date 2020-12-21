require_relative 'data_reader'

def validate_target(target, candidates)
  while candidate = candidates.pop do
    return true if candidates.include?(target - candidate)
  end
  false
end

data_stream = DataReader.new.data_from_file('datastream.txt')
weakness = nil

data_stream.drop(25).each_with_index do |target, index|
  unless validate_target(target, data_stream[index..index + 24])
    weakness = target
  end
end

data_stream.each_with_index do |candidate, index|
  n = 1
  candidates = [candidate]
  until candidates.sum >= weakness do
    candidates << data_stream[index+n]
    n +=1
  end
  if candidates.sum == weakness
    puts candidates.sum, candidates.min + candidates.max
    return
  end
end