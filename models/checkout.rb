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
      final - rule.(total_before_discount: final, basket: @basket)
    end.round(2)
  end

  private

  def total_before_discount
    @basket.inject(0) { |sum, product| sum + product.price }
  end
end
