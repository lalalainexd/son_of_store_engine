class Cart < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :line_items, :dependent => :destroy

  def add_product(product)
    current_item = line_items.where(:product_id => product.id).first
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product.id, price: product.price)
    end
    current_item
  end

  def self.find_valid(cart)
    Cart.find(cart)
  end

  def calculate_total_cost
    line_items.map { |item| item.total }.inject(0, :+)
  end

end
