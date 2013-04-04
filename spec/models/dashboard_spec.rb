require 'spec_helper'

describe Dashboard do
  it "product" do
    Dashboard.new.products
    Dashboard.new.orders
  end
end