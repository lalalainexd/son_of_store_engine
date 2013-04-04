require 'spec_helper'

describe Cart do
  describe 'cart_cost' do
    let!(:cart){Cart.create}
    let!(:product) {Product.create(name: "Name", description: "Description")}
    let!(:line_item){LineItem.create(product_id: 1, cart_id: 1,
    order_id: 1, quantity: 1, price: 24)}

    it "increases the line_item quantity when adding a duplicate product" do
      updated_line_item = cart.add_product(product)
      expect(updated_line_item.quantity).to eq(2)
    end
  end
end
