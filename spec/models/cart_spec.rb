require 'spec_helper'

describe Cart do
  describe 'cart_cost' do
    it "checks the cart cost" do
      pending
      cart = Cart.create()
      expect(cart.cart_cost(cart)).to be_eq 200
    end
  end
end
