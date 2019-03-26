class PromotialRule
  # if sum over minimum, discount by percent
  # setting[:minimum]
  # setting[:percent]
  def percentage_discount(setting)
    lambda do |args|
      return 0 if args[:total_before_discount] < setting[:minimum]
      args[:total_before_discount] * setting[:percent] / 100.00
    end
  end

  # if count of specified product over minimum, use specified price for that items
  # setting[:code]
  # setting[:minimum]
  # setting[:discount_price]
  def item_discount(setting)
    lambda do |args|
      target_products = args[:basket].select do |product|
        product.code == setting[:code]
      end
      return 0 if target_products.count < setting[:minimum]
      target_products.count * (target_products[0].price - setting[:discount_price])
    end
  end
end
