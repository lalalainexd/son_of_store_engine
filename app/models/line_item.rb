class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :product_id, :product, :quantity

  validates :cart_id, presence: true
  validates :product_id, presence: true

  belongs_to :product
  belongs_to :cart

  def increase_quantity
    quantity + 1
  end

  def decrease_quantity
    quantity - 1
  end
end
