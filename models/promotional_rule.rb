class PromotialRule
  # if sum over minimum, discount by percent
  def percentage_discount(setting)
    lambda do |args|
      return 0 if args[:total_before_discount] < setting[:minimum]
      args[:total_before_discount] * setting[:percent] / 100.00
    end
  end
end
