class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :product_id, :product, :quantity, :order_id, :price
  attr_accessor :total

  validates :product_id, presence: true

  belongs_to :product
  belongs_to :cart
  belongs_to :order

  def increase_quantity
    self.quantity += 1
    self.total = nil
    save
  end

  def decrease_quantity
    self.quantity -= 1
    self.total = nil
    save
  end

  def total
    @total ||= quantity * price
  end

  def historical_total
    quantity.to_i * price.to_i
  end
end
