class Checkout
  def initialize(promotional_rules)
    @basket = []
    @rules = promotional_rules
  end

  def scan(product)
    @basket << product
  end

  def total
    @rules.inject(total_before_discount) do |final, rule|
      final.round(2) - rule.(total_before_discount: total_before_discount)
    end
  end

  private

  def total_before_discount
    @basket.inject(0) { |sum, product| sum + product.price }
  end
end
