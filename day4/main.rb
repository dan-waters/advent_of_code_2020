require_relative 'passport_reader'

passports = PassportReader.new.passports_from_file('passports.txt')

valid_passports = passports.select do |passport|
  passport.valid?
end

puts valid_passports.count