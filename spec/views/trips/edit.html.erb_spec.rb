require 'spec_helper'

describe "trips/edit" do
  before(:each) do
    @trip = assign(:trip, stub_model(Trip,
      :children => 1,
      :adults => 1,
      :city_of_origin => "MyString",
      :pace => "MyString",
      :month_of_departure => "MyString"
    ))
  end

  it "renders the edit trip form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", trip_path(@trip), "post" do
      assert_select "input#trip_children[name=?]", "trip[children]"
      assert_select "input#trip_adults[name=?]", "trip[adults]"
      assert_select "input#trip_city_of_origin[name=?]", "trip[city_of_origin]"
      assert_select "input#trip_pace[name=?]", "trip[pace]"
      assert_select "input#trip_month_of_departure[name=?]", "trip[month_of_departure]"
    end
  end
end
