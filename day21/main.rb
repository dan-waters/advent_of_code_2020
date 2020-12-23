require 'open-uri'

Meal = Struct.new(:foods, :allergens) do
  def contains?(allergen)
    allergens.include?(allergen)
  end
end

meals = open('meals.txt').readlines(chomp: true).map do |meal|
  meal_matcher = /([a-z\s]+)\(contains ([a-z\s,]+)\)/
  match = meal.match(meal_matcher)
  foods, allergens = match[1].split(' '), match[2].split(', ')
  Meal.new(foods, allergens)
end

all_foods = meals.flat_map(&:foods)
all_allergens = meals.flat_map(&:allergens).uniq
candidates = {}

all_allergens.each do |allergen|
  foods = meals.select { |meal| meal.contains?(allergen)}.map(&:foods)
  candidates[allergen] = foods.inject(:&)
end

puts (all_foods - candidates.values.flatten).count


canonical_list = {}

until canonical_list.keys.count == 8 do
  can = candidates.detect{|k, v| v.count == 1}
  canonical_list[can[0]] = can[1][0]
  candidates.delete(can[0])
  candidates.values.each do |arr|
    arr.delete(can[1][0])
  end
end

puts canonical_list.sort_by{|k, v| k}.map{|k, v| v}.join(',')