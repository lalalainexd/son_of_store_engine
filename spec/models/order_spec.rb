require 'spec_helper'

describe Order do
  include_context "standard test dataset"
  let!(:new_user){User.new(full_name: "user",
      email: "user@oregonsale.com") }
  let!(:order){Order.create(status: "pending", user_id: 1, total_cost: 3372)}
  let!(:li){LineItem.create(product_id: 1, cart_id: nil,
  order_id: 1, quantity: 3, price: 24)}

  describe 'add_line_items' do
    it "adds order id to each line_item in a cart at checkout" do
      cart = Cart.create
      order.add_line_items(cart)
      order.line_items
    end
  end

  describe "generate random" do
    it "generates random thing" do
      a = order.generate_confirmation_code
      (order.generate_confirmation_code).should_not eq a
    end
  end

  describe "create_visitor_order" do
    it "creates a order with a visitor" do
      visitor = Visitor.new(email: "foo@bar.com")
      Visitor.should_receive(:create).and_return(visitor)
      Order.any_instance.should_receive(:save)
      cart = stub(:cart)

      order = Order.create_visitor_order(cart, "foo@bar.com", "")
      expect(order.visitor.email).to eq "foo@bar.com"
    end

  end

end
