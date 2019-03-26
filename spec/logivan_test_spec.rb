require "./models/product.rb"
require "./models/checkout.rb"
require "./models/promotional_rule.rb"

describe "logivan_test" do
  let(:percent_discount) do
    PromotialRule.new.discount({ minimum: 60.0, percent: 10.0 })
  end

  it "should discount 10% if total price is over 60" do
    checkout = Checkout.new([percent_discount])
    checkout.scan(Product.new("001", "Lavender heart", 100.00))
    checkout.total.equal?(90.00)
  end
end
