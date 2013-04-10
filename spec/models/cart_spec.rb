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

  describe 'add_product' do

    let(:cart){Cart.create}
    let(:product) {Product.create(name: "Name", description: "Description")}

    context 'add item that is not in the cart' do

      it 'creates a line item for the item' do
        cart.add_product(product)
        expect(cart.line_items.find_by_product_id(product.id)).to_not be_nil
      end
    end

    context 'add an item that already exists in the cart' do

      it 'increases the associated lineitem quantity by 1' do
        cart.add_product(product)

        expect{
          cart.add_product(product)
        }.to change{cart.line_items.first.quantity}.by(1)
      end

      it 'does not add a new line item'
    end

  end
end
