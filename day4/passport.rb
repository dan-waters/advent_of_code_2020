class Passport
  REQUIRED_FIELDS = %w[byr iyr eyr hgt hcl ecl pid]

  def initialize(fields)
    @fields = fields
  end

  def valid?
    REQUIRED_FIELDS.all? do |field|
      @fields.include?(field)
    end &&
        byr.between?(1920, 2002) &&
        iyr.between?(2010, 2020) &&
        eyr.between?(2020, 2030) &&
        (hgt =~ /(59|6\d|7[0-6])in/ || hgt =~ /1(5\d|6\d|7\d|8\d|9[0-3])cm/) &&
        hcl =~ /^#[0-9a-f]{6}$/ &&
        %w[amb blu brn gry grn hzl oth].include?(ecl) &&
        pid =~ /^[0-9]{9}$/
  end

  private

  def byr
    get_attribute('byr').to_i
  end

  def iyr
    get_attribute('iyr').to_i
  end

  def eyr
    get_attribute('eyr').to_i
  end

  def hgt
    get_attribute('hgt')
  end

  def hcl
    get_attribute('hcl')
  end

  def ecl
    get_attribute('ecl')
  end

  def pid
    get_attribute('pid')
  end

  def get_attribute(attr)
    @fields.split(',').detect { |field| field.include? attr }.split(':')[1]
  end
end