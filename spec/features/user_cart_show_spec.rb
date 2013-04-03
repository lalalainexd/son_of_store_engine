require 'spec_helper'
describe "cart show", js: true do
  let!(:c1) {Cart.create}
  let!(:p1) {Product.create(name: "Wagon", description: "test test")}
  let!(:p2) {Product.create(name: "Item", description: "test test")}
  let!(:p3) {Product.create(name: "Itemagain", description: "test test")}
  let!(:li1) {LineItem.create(product_id: p1.id, cart_id: c1.id, quantity: 1)}

  it "displays a cart" do
    visit cart_path(c1.id)
    page.should have_content "Cart"
  end

  it "does not display non-existant cart" do
    visit "/carts/9898"

    page.should have_content "Invalid cart."
  end

  context "cart with one or more items in it" do
    it "increases the quantity if plus sign is clicked" do
      visit cart_path(c1.id)
      page.should have_content "1"

      click_link "increase_quantity"
      page.should have_content "Product quantity has been updated."
      page.should have_content "2"
    end

    it "decreases the quantity if minus sign is clicked on >1 item" do
      visit cart_path(c1.id)
      page.should have_content "1"

      click_link "increase_quantity"
      page.should have_content "Product quantity has been updated."
      page.should have_content "2"

      click_link "decrease_quantity"
      page.should have_content "Product quantity has been updated."
      page.should have_content "1"
    end

    it "removes the item if minus sign is clicked item with quantity of 1" do
      visit cart_path(c1.id)
      page.should have_content "1"

      click_link "decrease_quantity"
      page.should have_content "Product quantity has been updated."
      page.should_not have_content "Wagon"
    end
  end
end
