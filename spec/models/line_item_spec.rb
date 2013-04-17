require 'spec_helper'

describe LineItem do
  it "total" do
    li = LineItem.new
    li.price = 3
    li.quantity = 10

    expect(li.total).to eq 30
  end

  it "hist_total" do
    li = LineItem.new
    li.price = 3
    li.quantity = 10

    expect(li.historical_total).to eq 30
  end
end