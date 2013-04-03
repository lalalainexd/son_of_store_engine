require 'spec_helper'

describe "Products", js: true do
  let!(:c1) {Category.create! name: "Grub" }
  let!(:p1) {Product.create( name: "Rations", price: 24,
  description: "Good for one 'splorer.", category_ids: ["1"])}
  let!(:p2) {Product.create( name: "Eggs", price: 5,
  description: "Farm fresh and ready to consume.", category_ids: ["1"])}
  let!(:p3) {Product.create( name: "Apples", price: 19,
  description: "Great for a snack!", category_ids: ["1"])}
  let!(:u1) {User.create full_name: "admin",
          email: 'admin@oregonsale.com',
          password: 'password',
          password_confirmation: 'password',
          role: 'admin'}

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

      it "can retire product 1" do
        pending
        visit '/admin'
        sleep 5
        click_link "retire_#{p1.id}"

        click_link "Retired"
        page.should have_content "#{p1.name}"
      end

      it 'can unretire product 2' do
        pending
        visit '/admin'
        click_link "retire_#{p2.id}"

        click_link "Retired"
        page.should have_content "#{p2.name}"

        click_link "unretire_#{p2.id}"

        page.should have_content "#{p2.name}"
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
