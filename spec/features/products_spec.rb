require 'spec_helper'

describe "Products" do

  before :each do
    Product.create(name: "Gun", description: "For hunting deerz", price: 123)
  end

  describe "GET /products" do
    it "works!!!!!!!!!!!!!!!!!!!!!!!!" do
      visit products_path
      page.should have_content "Oregon Sale"
    end

    it "clicking on name redirects to product's page" do
      visit products_path
      click_link("Gun")
      page.should have_content 'For hunting deerz'
    end
  end
end
