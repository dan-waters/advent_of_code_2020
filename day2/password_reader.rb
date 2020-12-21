require 'open-uri'
require_relative 'password_policy'

class PasswordReader
  def passwords_from_file(filename)
    passwords = open(filename).readlines
    passwords.map{|x| split_password_line(x)}
  end

  private

  def split_password_line(line)
    policy, password = line.split(':')
    {policy: PasswordPolicy.new(policy), password: password.strip}
  end
end