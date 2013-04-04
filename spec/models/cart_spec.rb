require 'spec_helper'

describe Cart do
  describe 'cart_cost' do
  let!(:cart1){Cart.create}
  let!(:p1) {Product.create(name: "Name", description: "Description")}
  let!(:li1){LineItem.create(product_id: 1, cart_id: 1,
  order_id: 1, quantity: 3, price: 24)}

    it "checks the cart cost" do
      pending
      cart1.cart_cost(cart1)
      expect(cart.cart_cost(cart)).to be_eq 200
    end
  end
end
