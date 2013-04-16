require 'spec_helper'

feature "Visitor checking out signs in while purchasing", %q{
  Given I am a visitor to the store "Cool Sunglasses"
  And I have added items to my cart
}do

  background do
    store = FactoryGirl.create(:store_with_products,
                               products_count: 5,
                               name: "Cool Sunglasses",
                               slug: "cool-sunglasses")

    cart = FactoryGirl.create(:cart)
    cart.add_product(store.products.first)
    page.set_rack_session(cart_id: cart.id)

    visit new_order_path

  end

  scenario "Visitor signs in during checkout" do



  end

end
