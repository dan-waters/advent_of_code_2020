require_relative 'rule_reader'

RULES = RuleReader.new.rules_from_file('rules.txt')

searched_count = 0
searched_bags = RULES.select { |rule| rule.contained_bags.map { |h| h[:colour] }.include?('shiny gold') }.map { |rule| rule.container_bag }.uniq

while searched_bags.count - searched_count > 0 do
  searched_count = searched_bags.count
  searched_bags += searched_bags.map do |bag|
    RULES.select { |rule| rule.contained_bags.map { |h| h[:colour] }.include?(bag) }.map { |rule| rule.container_bag }
  end.flatten
  searched_bags = searched_bags.uniq
end

puts searched_bags.uniq.count

@total_bags = 0

def search_in_bag(rule)
  rule.contained_bags.map do |bag|
    bag[:number].times do
      @total_bags += 1
      new_rule = RULES.detect { |r| r.container_bag == bag[:colour] }
      search_in_bag(new_rule)
    end
  end
end

shiny_gold_rule = RULES.detect { |rule| rule.container_bag == 'shiny gold' }

search_in_bag(shiny_gold_rule)

puts @total_bags