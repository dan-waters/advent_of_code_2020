require_relative 'ticket_reader'

rules = TicketReader.new.rules_from_file('tickets.txt')
tickets = TicketReader.new.tickets_from_file('tickets.txt')


ranges = rules.map do |rule|
  match = rule.match(/(\d+)-(\d+) or (\d+)-(\d+)/)
  range1 = (match[1].to_i..match[2].to_i)
  range2 = (match[3].to_i..match[4].to_i)
  [range1, range2]
end.flatten

invalid_values = []
tickets.each do |ticket|
  invalid_values += ticket.select do |number|
    ranges.all? do |range|
      !range.include?(number)
    end
  end
end

puts invalid_values.sum

valid_tickets = tickets.select do |ticket|
  ticket.all? do |number|
    ranges.any? do |range|
      range.include?(number)
    end
  end
end

puts valid_tickets.count

ticket_length = tickets.first.length

rules = rules.map do |rule|
  match = rule.match(/(.+): (\d+)-(\d+) or (\d+)-(\d+)/)
  description = match[1]
  range1 = (match[2].to_i..match[3].to_i)
  range2 = (match[4].to_i..match[5].to_i)
  {rule: description, ranges: [range1, range2]}
end

rule_ticket_map = {}
rules.each do |rule|
  rule_ticket_map[rule] = []
end

rules.each do |rule|
  (0..ticket_length - 1).each do |ticket_index|
    values = valid_tickets.map { |ticket| ticket[ticket_index] }
    if values.all? { |value| rule[:ranges][0].include?(value) || rule[:ranges][1].include?(value) }
      puts "rule #{rule[:rule]}, ticket_index #{ticket_index}"
      rule_ticket_map[rule] << ticket_index
    end
  end
end

puts rule_ticket_map

final_rules = {}

until final_rules.length == 20 do
  rule_ticket_map.sort_by { |k, v| v.length }.each do |k, v|
    if v.length == 1
      final_rules[k] = v.first
      rule_ticket_map.delete(k)
      rule_ticket_map.keys.each do |rule|
        rule_ticket_map[rule].delete(v.first)
      end
    end
  end
end

puts [137,173,167,139,73,67,61,179,103,113,163,71,97,101,109,59,131,127,107,53].values_at(*final_rules.select{|k,v| k[:rule] =~ /departure/}.values).inject(:*)