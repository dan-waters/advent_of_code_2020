require 'open-uri'

messages = open('messages.txt').readlines(chomp: true)

@rules = []

open('rules.txt').readlines(chomp: true).map do |rule|
  number, pattern = rule.split(': ')
  @rules[number.to_i] = pattern
end

@expanded_rules = []

def expand_rule(rule_no)
  rule = @rules[rule_no]
  chars = rule.split(' ')
  grouped = rule.include?('|')
  pattern = ''
  while chars.any? do
    char = chars.shift
    case char
    when /"a"/
      pattern += 'a'
    when /"b"/
      pattern += 'b'
    when /(\d+)/
      number = char.to_i
      pattern += @expanded_rules[number] || expand_rule(number)
    when /\|/
      pattern += '|'
    end
  end

  pattern = grouped ? "(#{pattern})" : pattern
  @expanded_rules[rule_no] = pattern
  pattern
end

rule = expand_rule(0)
puts rule

puts (messages.select do |message|
  message =~ /^#{rule}$/
end.count)

rule_42 = expand_rule(42)
rule_31 = expand_rule(31)

puts (messages.select do |message|
  message =~ /^#{rule_42}+(?<rule_11>#{rule_42}#{rule_31}|#{rule_42}\g<rule_11>?#{rule_31})$/
end.count)