class Order < ActiveRecord::Base
  attr_accessible :status, :user_id, :total_cost
  attr_accessor :stripe_card_token

  has_many :line_items, :dependent => :destroy
  belongs_to :user

  def add_line_items(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def self.create_from_cart_for_user(cart, user, card)
    total_cost = cart.calculate_total_cost
    order = Order.new( status:     "pending",
                       user_id:    user.id,
                       total_cost: total_cost)
    order.add_line_items(cart)
    order.save_with_payment(card)
  end

  def save_with_payment(card_token)
    if valid?
      Stripe::Charge.create(amount: total_cost, card: card_token, currency: "usd")
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating charge: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

end
