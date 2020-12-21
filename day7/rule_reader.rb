require 'open-uri'
require_relative 'rule'

class RuleReader
  def rules_from_file(filename)
    open(filename).readlines.map(&:strip).map{|r| Rule.new(r)}
  end
end