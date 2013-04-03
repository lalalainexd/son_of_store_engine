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

  def save_with_payment(stripe_card_token)
    if valid?
      Stripe::Charge.create(amount: total_cost, card: stripe_card_token, currency: "usd")
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating charge: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

end
