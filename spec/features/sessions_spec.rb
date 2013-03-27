require 'spec_helper'

describe "Sessions", js: true do
  context "when user logs in" do
    context "if user exists" do
      it "logs in user" do

        User.create email: 'user@oregonsale.com',
          password: 'password',
          password_confirmation: 'password',
          role: 'admin'

        visit '/login'
        fill_in 'email', with: 'user@oregonsale.com'
        fill_in 'password', with: 'password'
        click_button "Log in"

        expect(current_path).to eq root_path
      end
    end

    context "if user does not exist" do
      it "returns error message" do
        visit '/login'
        fill_in 'email', with: 'user@oregonsale.com'
        fill_in 'password', with: 'password'
        click_button "Log in"

        page.should have_content "Email or password was invalid"
      end
    end
  end

  context "when user is logged in" do
    it "can log out" do
      User.create email: 'user@oregonsale.com',
          password: 'password',
          password_confirmation: 'password',
          role: 'admin'

        visit '/login'
        fill_in 'email', with: 'user@oregonsale.com'
        fill_in 'password', with: 'password'
        click_button "Log in"

        click_link "Log out"

        page.should have_content "Logged out."
    end
  end
end
