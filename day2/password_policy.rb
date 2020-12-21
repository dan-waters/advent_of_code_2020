class PasswordPolicy
  def initialize(rule)
    times, @letter = rule.split(' ')
    @mintimes, @maxtimes = times.split('-').map(&:to_i)
    @position1, @position2 = @mintimes, @maxtimes
  end

  def inspect
    "#<PasswordPolicy: #{@mintimes}-#{@maxtimes} #{@letter}>"
  end

  def test_counts(password)
    count = password.count(@letter)
    count >= @mintimes && count <= @maxtimes
  end

  def test_positions(password)
    letter1 = password[@position1 - 1]
    letter2 = password[@position2 - 1]
    if letter1 == letter2
      false
    else
      letter1 == @letter || letter2 == @letter
    end
  end
end
