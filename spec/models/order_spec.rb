require 'spec_helper'

describe Order do
  include_context "standard test dataset"
  let!(:new_user){User.new(full_name: "user",
      email: "user@oregonsale.com") }
  let!(:order){Order.create(status: "pending", user_id: 1, total_cost: 3372)}
  let!(:li){LineItem.create(product_id: 1, cart_id: nil,
  order_id: 1, quantity: 3, price: 24)}

  describe "generate random" do
    it "generates random thing" do
      a = order.generate_confirmation_code
      (order.generate_confirmation_code).should_not eq a
    end
  end

  describe "create_visitor_order" do
    let(:cart) { stub(:cart, calculate_total_cost: 42) }
    let(:visitor) { Visitor.new(email: "foo@bar.com") }

    before do
      Order.any_instance.should_receive(:save)
      Order.any_instance.should_receive(:add_line_items).with(cart)
      Order.any_instance.should_receive(:save_with_payment).with("4242")
      Visitor.should_receive(:create).with(email: "foo@bar.com").and_return(visitor)
    end

    it "creates a order with a visitor" do
      order = Order.create_visitor_order(cart, "foo@bar.com", "4242")
      expect(order.visitor.email).to eq "foo@bar.com"
    end

    it "creates an order with total cost" do
      order = Order.create_visitor_order(cart, "foo@bar.com", "4242")
      expect(order.total_cost).to eq 42
    end
  end

end
