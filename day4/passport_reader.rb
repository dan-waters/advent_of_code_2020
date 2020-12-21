require 'open-uri'
require_relative 'passport'

class PassportReader
  def passports_from_file(filename)
    passports = open(filename).read.split(/\n{2,}/)
    clean_passports = passports.map do |passport|
      Passport.new(passport.strip.gsub(/\s/, ','))
    end
  end
end