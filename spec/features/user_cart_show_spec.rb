require 'spec_helper'
describe "cart show" do
  before(:each) do
    @cart = Cart.create
    @product = Product.create(name: "Wagon", description: "test test")
    @line_item = LineItem.create(product_id: @product.id, cart_id: @cart.id, quantity: 1)
  end

  it "displays a cart" do
    visit "/carts/#{@cart.id}"
    page.should have_content "Cart"
  end

  context "cart with one or more items in it" do
    it "increases the quantity if plus sign is clicked"
  end
end
