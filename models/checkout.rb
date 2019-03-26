class Checkout
  def initialize(promotial_rules)
    @basket = []
    @price = 0
    @rules = promotial_rules
  end

  def scan(item)
    @basket << item
  end

  def total
    total = total_before_discount
    @rules.each do |rule|
      total = total - rule.call(total_before_discount: total_before_discount)
    end
    total
  end

  def total_before_discount
    sum = 0
    @basket.each do |item|
      sum = sum + item.price
    end
    sum
  end
end
