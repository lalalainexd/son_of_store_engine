require 'spec_helper'

describe LineItem do
  include_context "standard test dataset"
  it "total" do
    li = LineItem.create(product_id: 1, cart_id: nil,
      order_id: 1, quantity: 3, price: 24)
    Order.create(status: "pending", user_id: 1, total_cost: 3372)
    expect(li.total).to eq 72 
  end

  it "hist_total" do
    li = LineItem.create(product_id: 1, cart_id: nil,
      order_id: 1, quantity: 3, price: 24)
    Order.create(status: "pending", user_id: 1, total_cost: 3372)
    expect(li.historical_total).to eq 72 
  end 
end