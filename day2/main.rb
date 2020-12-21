require_relative 'password_reader'

passwords = PasswordReader.new.passwords_from_file('passwords.csv')

puts passwords.count {|password_combo| password_combo[:policy].test_counts(password_combo[:password])}

puts passwords.count {|password_combo| password_combo[:policy].test_positions(password_combo[:password])}