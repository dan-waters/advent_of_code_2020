require_relative 'expenses_reader'
require_relative 'expenses_calculator'

expenses = ExpensesReader.new.expenses_from_file('inputs.csv')

puts ExpensesCalculator.new.product_of_2(expenses, 2020)
puts ExpensesCalculator.new.product_of_3(expenses, 2020)

