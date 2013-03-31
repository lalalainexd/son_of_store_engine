require 'spec_helper'
describe "cart show", js: true do
  let!(:c1) {Cart.create}
  let!(:p1) {Product.create(name: "Wagon", description: "test test")}
  let!(:li1) {LineItem.create(product_id: p1.id, cart_id: c1.id, quantity: 1)}

  it "displays a cart" do
    visit "/carts/#{c1.id}"
    page.should have_content "Cart"
  end

  context "cart with one or more items in it" do
    it "increases the quantity if plus sign is clicked" do
      visit "/carts/#{c1.id}"
      page.should have_content "1"

      click_link "increase_quantity"
      page.should have_content "Product quantity has been updated."
      page.should have_content "2"
    end
  end
end
