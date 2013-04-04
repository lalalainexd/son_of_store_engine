require 'spec_helper'

describe "Products", js: true do
  include_context "standard test dataset"
  let!(:u1) {User.create full_name: "admin",
          email: 'admin@oregonsale.com',
          password: 'password',
          password_confirmation: 'password',
          role: 'superuser'}

  describe "GET /products" do
    context "user is logged in" do
      before (:each) do
        visit '/login'
        fill_in 'email', with: 'admin@oregonsale.com'
        fill_in 'password', with: 'password'
        click_button "Log in"
      end


      it "can create new product" do
        visit '/products/new'
        fill_in 'product_name', with: 'Toy'
        fill_in 'product_price', with: 5
        click_button 'Create Product'
        page.should have_content "Name: Toy"
      end

      it "can edit product 1" do
        initial_name = Product.all.first.name
        visit '/products/1/edit'
        fill_in 'product_name', with: "Gun"
        click_button 'Update Product'
        expect(Product.all.first.name).to_not equal initial_name
      end

      it "can retire product" do
        visit '/admin'
        click_link "Grub"
        click_link "retire_1"

        click_link "Retired"
        page.should have_content "#{p1.name}"
      end

      it 'can unretire product 2' do
        visit '/admin'
        click_link "Grub"
        click_link "retire_2"

        click_link "Retired"
        page.should have_content "Apples"

        click_link "unretire_2"
        click_link "Grub"
        page.should have_content "Apples"
      end
    end

    context "user not logged in" do
      it "cannot create new product" do
        visit '/products/new'
        page.should have_content "Access denied"
      end
    end
  end
end
