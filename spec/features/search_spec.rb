require 'spec_helper'

describe "Products", js: true do
  include_context "standard test dataset"
  let!(:u1) {User.create full_name: "admin",
          email: 'admin@oregonsale.com',
          password: 'password',
          password_confirmation: 'password',
          role: 'admin'}

  describe "GET /products", js: true do 
      before (:each) do
        visit '/login'
        fill_in 'email', with: 'admin@oregonsale.com'
        fill_in 'password', with: 'password'
        click_button "Log in"
      end

    context "user not logged in" do
      it "cannot create new product" do
        visit "/"
        fill_in 'search', with: 'rations'
        click_on("click_search")
        page.should have_content "Pioneering (admin mode) as admin"
      end
    end
  end
end
