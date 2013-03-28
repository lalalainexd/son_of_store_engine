require 'spec_helper'

describe "Users", js: true do
  let!(:p1) {Product.create( name: "Rations", price: 24,
  description: "Good for one 'splorer.")}
  let!(:p2) {Product.create( name: "Eggs", price: 5,
  description: "Farm fresh and ready to consume.")}
  let!(:p3) {Product.create( name: "Apples", price: 19,
  description: "Great for a snack!")}

  context "when user credentials are invalid" do
    it "returns user to form" do
      visit '/signup'
      fill_in 'user_email', with: 'user@oregonsale.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'not_password'
      click_button "Sign Up!"

      page.should have_content "Password doesn't match confirmation"
    end
  end
end