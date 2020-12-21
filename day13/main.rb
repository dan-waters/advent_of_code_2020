timestamp = 1002632
schedule = '23,x,x,x,x,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,x,829,x,x,x,x,x,x,x,x,x,x,x,x,13,17,x,x,x,x,x,x,x,x,x,x,x,x,x,x,29,x,677,x,x,x,x,x,37,x,x,x,x,x,x,x,x,x,x,x,x,19'

buses = schedule.split(',')

puts buses.reject { |bus| bus == 'x' }.map { |bus| "bus: #{bus}, time: #{bus.to_i - (timestamp % bus.to_i)}" }

jump = 1
answer = 0

buses.each_with_index do |bus, minute|
  next if bus == 'x'
  bus = bus.to_i
  until (answer + minute) % bus == 0
    answer += jump
  end
  jump = jump.lcm(bus)
end

puts answer

