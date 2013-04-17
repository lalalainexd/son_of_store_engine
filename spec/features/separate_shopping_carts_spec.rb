require 'spec_helper'

feature "maintain separate shopping carts for each store a user visits" do

  background do
  end

  describe "a user visits a store and adds a product to their cart" do

    it "saves the product to the cart associated with the user and store" do
      store = FactoryGirl.create(:store_with_products,
                               products_count: 1,
                               name: "Cool Sunglasses",
                               status: "enabled",
                               slug: "cool-sunglasses")
      visit home_path(store)
      click_button "Add to Cart"
      expect(page).to have_content("Checkout")

    end
  end

end
