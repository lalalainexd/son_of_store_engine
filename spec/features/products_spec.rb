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
  end
end
