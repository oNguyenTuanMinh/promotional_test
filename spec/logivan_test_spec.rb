require "./models/product.rb"
require "./models/checkout.rb"
require "./models/promotional_rule.rb"

describe "logivan_test" do
  describe "when discounts triggered" do
    let(:percentage_discount) do
      PromotialRule.new.percentage_discount({ minimum: 60.00, percent: 10.00 })
    end

    it "should discount 10% if total price is over 60" do
      checkout = Checkout.new([percentage_discount])
      checkout.scan(Product.new("001", "Lavender heart", 100.00))
      expect(checkout.total).to equal(90.0)
    end

    test_case1 = <<-STR
    -------------------------------------
    Test case #1
    Basket: 001,002,003
    Total price expected: £66.78
    -------------------------------------
    STR

    it test_case1 do
      checkout = Checkout.new([percentage_discount])
      checkout.scan(Product.new("001", "Lavender heart", 9.25))
      checkout.scan(Product.new("002", "Personalised cufflinks", 45.00))
      checkout.scan(Product.new("003", "are neat", 19.95))
      expect(checkout.total).to equal(66.78)
    end
  end
end
