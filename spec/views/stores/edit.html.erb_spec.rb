require 'spec_helper'

describe "stores/edit" do
  before(:each) do
    @store = assign(:store, stub_model(Store,
      :name => "MyString",
      :slug => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit store form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", store_path(@store), "post" do
      assert_select "input#store_name[name=?]", "store[name]"
      assert_select "input#store_slug[name=?]", "store[slug]"
      assert_select "textarea#store_description[name=?]", "store[description]"
    end
  end
end
