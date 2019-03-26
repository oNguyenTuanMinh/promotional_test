class Product
  attr_accessor :code, :name, :price

  def initialize(*args)
    @code, @name, @price = args
  end
end
