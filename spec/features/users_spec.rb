require 'spec_helper'

describe "Users", js: true do
  include_context "standard test dataset"

  context "when user credentials are invalid" do
    it "returns user to form" do
      visit '/signup'
      fill_in 'user_email', with: 'user@oregonsale.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'not_password'
      click_button "Sign Up!"

      page.should have_content "Password doesn't match confirmation"
    end

    it "when user renders show without logging in" do
      visit '/users/1'

      page.should have_content "You are not permitted to view that user"
    end
  end

  context "user logs in" do
    it "can see invoice history" do
      visit '/signup'
      fill_in "user_full_name", with: "joe schmo"
      fill_in 'user_email', with: 'user@oregonsale.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button "Sign Up!"

      visit '/login'
      fill_in 'email', with: 'user@oregonsale.com'
      fill_in 'password', with: 'password'
      click_button 'Log in'
      
      visit profile_path
      page.should have_content "Invoices for joe schmo"
    end
  end
end