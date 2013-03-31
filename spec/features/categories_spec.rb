require 'spec_helper'

describe "Categories", js: true do
  let!(:c1) {Category.create! name: "Grub"}
  let!(:p1) {Product.create( name: "Rations", price: 24,
  description: "Good for one 'splorer.", category_ids: ["1"])}
  let!(:p2) {Product.create( name: "Eggs", price: 5,
  description: "Farm fresh and ready to consume.", retired: true, category_ids: ["1"])}
  let!(:p3) {Product.create( name: "Apples", price: 19,
  description: "Great for a snack!", category_ids: ["1"])}
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