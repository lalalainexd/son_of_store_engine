class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :product_id, :product, :quantity, :order_id, :price

  validates :product_id, presence: true

  belongs_to :product
  belongs_to :cart
  belongs_to :order

  def increase_quantity
    self.quantity += 1
    save
  end

  def decrease_quantity
    self.quantity -= 1
    save
  end

  def total
    quantity.to_i * product.price.to_i
  end

  def historical_total
    quantity.to_i * price.to_i
  end
end
