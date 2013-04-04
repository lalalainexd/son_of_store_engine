require 'spec_helper'

describe "Categories", js: true do
  include_context "standard test dataset"
  let!(:u1) {User.create email: 'admin@oregonsale.com',
          password: 'password',
          password_confirmation: 'password',
          role: 'admin'}

  describe "can render pages if admin" do
    before (:each) do
      visit '/login'
      fill_in 'email', with: 'admin@oregonsale.com'
      fill_in 'password', with: 'password'
      click_button "Log in"
    end

    it "/categories" do
      visit '/categories'
    end

    it 'categories/new' do
      visit '/categories/new'
    end
  end

  describe "cannot render pages if regular user / not logged in" do
    it "/categories" do
      visit '/categories'

      page.should have_content "Access denied"
    end

    it 'categories/new' do
      visit '/categories/new'

      page.should have_content "Access denied"
    end
  end

end