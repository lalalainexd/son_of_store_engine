class Order < ActiveRecord::Base
  attr_accessible :status, :user_id, :total_cost

  has_many :line_items, :dependent => :destroy

  belongs_to :user

  def add_line_items(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def self.create_from_cart_for_user(cart, user)
    total_cost = cart.calculate_total_cost
    order = Order.new(status: "pending", user_id: user.id, total_cost: total_cost)
    order.add_line_items(cart)
    order.save
  end

end
