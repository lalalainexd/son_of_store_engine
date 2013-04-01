class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :product_id, :product, :quantity, :order_id

  validates :product_id, presence: true

  belongs_to :product
  belongs_to :cart
  belongs_to :order

  def increase_quantity
    quantity + 1
  end

  def decrease_quantity
    quantity - 1
  end

  def total
    quantity * product.price
  end
end
