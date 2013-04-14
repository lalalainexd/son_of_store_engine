require 'spec_helper'

describe Cart do
  let(:cart){Cart.create}
  let(:product) {
    Product.new.tap do |product|
    product.name = "Name"
    product.description = "Description"
    product.store = Store.create(name: "store", slug:"slug")
    product.save
    end
  }
  let!(:line_item){LineItem.create(product_id: 1, cart_id: 1,
                                   order_id: 1, quantity: 1, price: 24)}

  describe 'add_product' do

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

      it 'does not add a new line item' do
        cart.add_product(product)

        expect{
          cart.add_product(product)
        }.to change{cart.line_items.count}.by(0)
      end
    end

  end
end
