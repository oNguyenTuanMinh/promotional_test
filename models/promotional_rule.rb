class PromotialRule
  def discount(setting)
    Proc.new do |args|
      if args[:total_before_discount] >= setting[:minimum]
        args[:total_before_discount] * setting[:percent] / 100
      else
        0
      end
    end
  end
end
