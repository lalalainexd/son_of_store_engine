require 'spec_helper'

describe "Orders", js: true do
  include_context "standard test dataset"

  let!(:u1) {User.create full_name: "admin",
          email: 'admin@oregonsale.com',
          password: 'password',
          password_confirmation: 'password',
          role: 'admin'}
  let!(:li1){LineItem.create(product_id: 1, cart_id: nil,
  order_id: 1, quantity: 3, price: 24)}
  let!(:o1){Order.create(status: "pending", user_id: 1, total_cost: 3372)}

  context "admin is logged in" do
    before (:each) do
      visit '/login'
      fill_in 'email', with: 'admin@oregonsale.com'
      fill_in 'password', with: 'password'
      click_button "Log in"
    end

    it "can go to index" do
      visit "/orders"
    end 

    it "can go to show" do
      visit "/orders/1"
    end

    it "can edit status" do
      visit "/orders/1"
      click_link "Paid"
    end

    it 'can visit new page' do
      
    end


  end


end
