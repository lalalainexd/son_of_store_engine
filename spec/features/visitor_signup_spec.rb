require 'spec_helper'

feature "StoreEngine visitor creates a new account", %q{
  Give I am not logged in
  And I am on a particular page
} do

  let(:store) { FactoryGirl.create(:store, status: "enabled") }

  background do
    visit home_path(store)
    click_link("Sign up")
  end

  scenario "Visitor signs up successfully", js: true do

    expect(current_path).to eq signup_path

    fill_in("user_full_name", with: "Joe")
    fill_in("user_email", with: "joe@joe.com")
    fill_in("user_password", with: "password")
    fill_in("user_password_confirmation", with: "password")

    click_link_or_button("Create Account")

    expect(current_path).to eq home_path(store)

    within("div.alert.fade.in.alert-success") do
      expect(find('a')['href']).to include(edit_profile_path)
    end

    within("div.main_nav") do
      expect(find('a:last')['href']).to include(logout_path)
    end

  end


  end
