require 'spec_helper'

describe "trips/index" do
  before(:each) do
    assign(:trips, [
      stub_model(Trip,
        :children => 1,
        :adults => 2,
        :city_of_origin => "City Of Origin",
        :pace => "Pace",
        :month_of_departure => "Month Of Departure"
      ),
      stub_model(Trip,
        :children => 1,
        :adults => 2,
        :city_of_origin => "City Of Origin",
        :pace => "Pace",
        :month_of_departure => "Month Of Departure"
      )
    ])
  end

  it "renders a list of trips" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "City Of Origin".to_s, :count => 2
    assert_select "tr>td", :text => "Pace".to_s, :count => 2
    assert_select "tr>td", :text => "Month Of Departure".to_s, :count => 2
  end
end
