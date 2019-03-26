require "./models/product.rb"
require "./models/checkout.rb"
require "./models/promotional_rule.rb"

describe "logivan_test" do
  describe "when discounts triggered" do
    let(:percentage_discount) do
      PromotialRule.new.percentage_discount({ minimum: 60.00, percent: 10.00 })
    end

    let(:item_discount) do
      PromotialRule.new.item_discount({
        code: "001",
        minimum: 2,
        discount_price: 10.00
      })
    end

    context "when only percentage_discount is available" do
      it "should discount 10% if total price is over 60" do
        checkout = Checkout.new([percentage_discount])
        checkout.scan(Product.new("001", "Lavender heart", 100.00))
        expect(checkout.total).to equal(90.0)
      end

      it "should discount 10% if total price is exactly 60" do
        checkout = Checkout.new([percentage_discount])
        checkout.scan(Product.new("001", "Lavender heart", 20.00))
        checkout.scan(Product.new("002", "Personalised cufflinks", 40.00))
        expect(checkout.total).to equal(54.0)
      end

      it "should not discount 10% if total price is over 59.9" do
        checkout = Checkout.new([percentage_discount])
        checkout.scan(Product.new("001", "Lavender heart", 20.00))
        checkout.scan(Product.new("002", "Personalised cufflinks", 30.00))
        expect(checkout.total).to equal(50.0)
      end
    end

    context "when only item_discount is available" do
      it "should use 15.00 as normal when there is one '001' product" do
        checkout = Checkout.new([item_discount])
        checkout.scan(Product.new("001", "Lavender heart", 15.00))
        expect(checkout.total).to equal(15.00)
      end

      it "should use 10.00 as discount_price when there are two '001' product" do
        checkout = Checkout.new([item_discount])
        checkout.scan(Product.new("001", "Lavender heart", 15.00))
        checkout.scan(Product.new("001", "Lavender heart", 15.00))
        expect(checkout.total).to equal(20.00)
      end

      it "should use 10.00 as normal when there are more than two '001' product" do
        checkout = Checkout.new([item_discount])
        checkout.scan(Product.new("001", "Lavender heart", 15.00))
        checkout.scan(Product.new("001", "Lavender heart", 15.00))
        checkout.scan(Product.new("001", "Lavender heart", 15.00))
        checkout.scan(Product.new("001", "Lavender heart", 15.00))
        expect(checkout.total).to equal(40.00)
      end
    end

    describe "TEST CASES" do
      let(:product_001) { Product.new("001", "Lavender heart", 9.25) }
      let(:product_002) { Product.new("002", "Personalised cufflinks", 45.00) }
      let(:product_003) { Product.new("003", "are neat", 19.95) }

      let(:percentage_discount) do
        PromotialRule.new.percentage_discount({ minimum: 60.00, percent: 10.00 })
      end

      let(:item_discount) do
        PromotialRule.new.item_discount({
          code: "001",
          minimum: 2,
          discount_price: 8.50
        })
      end

      let(:checkout) do
        Checkout.new([item_discount, percentage_discount])
      end

      subject { checkout.total }

      test_case1 = <<-STR
      -------------------------------------
      Test case #1
      Basket: 001,002,003
      Total price expected: £66.78
      -------------------------------------
      STR

      it test_case1 do
        checkout.scan(product_001)
        checkout.scan(product_002)
        checkout.scan(product_003)
        is_expected.to equal(66.78)
      end

      test_case2 = <<-STR
      -------------------------------------
      Test case #2
      Basket: 001,003,001
      Total price expected: £36.95
      -------------------------------------
      STR

      it test_case2 do
        checkout.scan(product_001)
        checkout.scan(product_003)
        checkout.scan(product_001)
        is_expected.to equal(36.95)
      end

      test_case3 = <<-STR
      -------------------------------------
      Test case #3
      Basket: 001,002,001,003
      Total price expected: £73.76
      -------------------------------------
      STR

      it test_case3 do
        checkout.scan(product_001)
        checkout.scan(product_002)
        checkout.scan(product_001)
        checkout.scan(product_003)
        is_expected.to equal(73.76)
      end
    end
  end
end
