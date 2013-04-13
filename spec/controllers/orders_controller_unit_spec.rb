require 'spec_helper'

describe OrdersController do
  it "adds an order to visitor" do
    cart = stub(:cart)
    subject.should_receive(:current_cart).and_return(cart)
    email = "foo@bar.com"
    billing_info = "blah"
    Order.should_receive(:create_visitor_order).with(cart, email, billing_info)
    post :create, {order:{ visitor: {email: "foo@bar.com"}, stripe_card_token: billing_info} }
  end
end
