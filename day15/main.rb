numbers = [9, 12, 1, 4, 17, 0, 18]

spoken_at = {}
numbers.each_with_index { |n, i| spoken_at[n] = [i] }

until numbers.length == 30_000_000 do
  current_index = numbers.length
  compare = numbers.last
  spoken = 0

  previous_times = spoken_at[compare]

  if previous_times.nil? || previous_times.length == 1
    numbers << spoken
  elsif previous_times.length > 1
    spoken = (previous_times[-1] - previous_times[-2])
    numbers << spoken
  end

  if spoken_at[spoken].nil?
    spoken_at[spoken] = [current_index]
  else
    spoken_at[spoken] << current_index
  end
end

puts numbers.length, numbers.last