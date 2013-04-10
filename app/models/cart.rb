class Cart < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :line_items, :dependent => :destroy

  def add_product(product, quantity=1)
    current_item = line_items.where(:product_id => product.id).first
    if current_item
      current_item.quantity += quantity
    else
      current_item = line_items.build(product_id: product.id,
                price: product.price, quantity: quantity)
    end
    current_item.save
    current_item
  end

  def calculate_total_cost
    line_items.map { |item| item.total }.inject(0, :+)
  end

end
