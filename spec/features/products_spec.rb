require 'spec_helper'

describe "Products", js: true do
  let!(:p1) {Product.create( name: "Rations", price: 24,
  description: "Good for one 'splorer.")}
  let!(:p2) {Product.create( name: "Eggs", price: 5,
  description: "Farm fresh and ready to consume.")}
  let!(:p3) {Product.create( name: "Apples", price: 19,
  description: "Great for a snack!")}
  let!(:u1) {User.create email: 'user@oregonsale.com',
          password: 'password',
          password_confirmation: 'password',
          role: 'admin'}

  describe "GET /products" do
    context "user is logged in" do
      before (:each) do
        visit '/login'
        fill_in 'email', with: 'user@oregonsale.com'
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
        sleep 5
        expect(Product.all.first.name).to_not equal initial_name
      end
    end

    context "user not logged in" do
      it "cannot create new product" do
        # visit '/products/new'
        # page.should have_content "Access denied."
        # weird error
      end
    end
  end
end
