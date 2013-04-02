require 'spec_helper'

describe "orders/show" do
  before(:each) do
    @order = assign(:order, stub_model(Order,
      :status => "Status",
      :user_id => 1
    ))
  end
end
