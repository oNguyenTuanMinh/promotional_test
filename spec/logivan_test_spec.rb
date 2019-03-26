require "./models/product.rb"
require "./models/checkout.rb"
require "./models/promotional_rule.rb"

describe "logivan_test" do
  let(:percentage_discount) do
    PromotialRule.new.percentage_discount({ minimum: 60.00, percent: 10.00 })
  end

  it "should discount 10% if total price is over 60" do
    checkout = Checkout.new([percentage_discount])
    checkout.scan(Product.new("001", "Lavender heart", 100.00))
    checkout.total.equal?(90.00)
  end
end
