require 'open-uri'

class TicketReader
  def rules_from_file(filename)
    open(filename).readlines(chomp: true).take(20)
  end

  def tickets_from_file(filename)
    open(filename).readlines(chomp: true).drop(25).map { |ticket_line| ticket_line.split(',').map(&:to_i) }
  end
end