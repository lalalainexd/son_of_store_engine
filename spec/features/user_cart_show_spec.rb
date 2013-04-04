require 'spec_helper'
describe "cart show", js: true do
  include_context "standard test dataset"

  it "displays a cart" do
    visit my_cart_path
    page.should have_content "Cart"
  end

  context "cart with one or more items in it" do
    before(:each) do
      
    end


    it "increases the quantity if plus sign is clicked" do
      # pending
      # page.should have_content "1"
      # click_link "increase_quantity"
      # page.should have_content "Product quantity has been updated."
      # page.should have_content "2"
    end

    it "decreases the quantity if minus sign is clicked on >1 item" do
      # pending
      # page.should have_content "1"

      # click_link "increase_quantity"
      # page.should have_content "Product quantity has been updated."
      # page.should have_content "2"

      # click_link "decrease_quantity"
      # page.should have_content "Product quantity has been updated."
      # page.should have_content "1"
    end

    it "removes the item if minus sign is clicked item with quantity of 1" do
      # pending
      # page.should have_content "1"

      # click_link "decrease_quantity"
      # page.should have_content "Product quantity has been updated."
      # page.should_not have_content "Wagon"
    end
  end
end
