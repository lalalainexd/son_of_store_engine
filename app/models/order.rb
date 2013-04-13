class Order < ActiveRecord::Base
  attr_accessible :status, :user_id, :total_cost, :confirmation
  attr_accessor :stripe_card_token

  has_many :line_items, :dependent => :destroy
  belongs_to :user
  has_one :visitor_order
  has_one :visitor, through: :visitor_order

  def add_line_items(cart)
    cart.line_items.each do |item|
      item.cart_id = nil; line_items << item
    end
  end

  def generate_confirmation_code
    self.confirmation ||= Digest::SHA1.hexdigest("#{visitor.email}#{created_at}")[0..8]
  end

  def self.create_from_cart_for_user(cart, user, card)

    order = Order.new.tap do |order|
      status  = "pending",
      user_id = user.id,
      total_cost = cart.calculate_total_cost
      order.add_line_items(cart)
      order.save_with_payment(card)
      order.save
    end

  end

  def self.create_visitor_order cart, email, card
    Order.new.tap do |order|
      order.total_cost = cart.calculate_total_cost
      order.visitor = Visitor.create(email: email)
      order.add_line_items(cart)
      order.save_with_payment(card)
      order.save
    end
  end

  def save_with_payment(card_token)
    if valid?
      Stripe::Charge.create(amount: total_cost, card: card_token,
                            currency: "usd")
      self.status = "paid"
      self.confirmation = generate_confirmation_code; save!; self
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating charge: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

end
