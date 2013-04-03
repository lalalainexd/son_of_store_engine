require 'spec_helper'

describe "trips/show" do
  before(:each) do
    @trip = assign(:trip, stub_model(Trip,
      :children => 1,
      :adults => 2,
      :city_of_origin => "City Of Origin",
      :pace => "Pace",
      :month_of_departure => "Month Of Departure"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/City Of Origin/)
    rendered.should match(/Pace/)
    rendered.should match(/Month Of Departure/)
  end
end
