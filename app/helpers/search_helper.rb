module SearchHelper
  def user_from_order_id(order_id)
    order = Order.where(id: order_id.to_i).first
    user = User.where(id: order.user_id.to_i).first
  end
end
