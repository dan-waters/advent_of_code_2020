require 'open-uri'

class ExpensesReader
  def expenses_from_file(filename)
    expenses_file = open(filename).readlines
    expenses_file.map { |x| x.to_i }
  end
end