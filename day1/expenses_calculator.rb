class ExpensesCalculator
  def product_of_2(expenses, target)
    expenses = expenses.dup
    while expenses.any? do
      attempt = expenses.pop
      expenses.select { |x| x + attempt == target }.each do |match|
        return {entries: [match, attempt], product: match * attempt}
      end
    end
  end

  def product_of_3(expenses, target)
    expenses = expenses.dup
    while expenses.any? do
      attempt = expenses.pop
      remainder = product_of_2(expenses, target - attempt)
      return {entries: [attempt] + remainder[:entries], product: remainder[:product] * attempt} if remainder
    end
  end
end