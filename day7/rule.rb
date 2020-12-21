class Rule
  def initialize(rule_string)
    @container_bag = rule_string.split('contain')[0].strip.match(/(.+) bags/)[1]
    @contained_bags = rule_string.split('contain')[1].strip
    if @contained_bags != 'no other bags.'
      @contained_bags = @contained_bags.split(',')
      @contained_bags = @contained_bags.map { |bag| bag.match(/(.+) bags?.?/)[1] }
      @contained_bags = @contained_bags.map { |bag| {number: bag.match(/(\d+) (.+)/)[1].to_i, colour: bag.match(/(\d+) (.+)/)[2]} }
    else
      @contained_bags = []
    end
  end

  def to_s
    "\"#{@container_bag}\" contain #{@contained_bags.join(',')}"
  end

  def container_bag
    @container_bag
  end

  def contained_bags
    @contained_bags
  end

  def contained_bag_count
    @contained_bags.map{|h| h[:number]}.sum
  end
end