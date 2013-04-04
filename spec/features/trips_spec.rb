require 'spec_helper'

describe "Trips", js: true do
  include_context "standard test dataset"

  describe 'new' do
    it "can visit new form" do
      visit '/trips/new'
      page.should have_content "Plan your"
    end
  end

  describe 'show' do
    it "shows basic details" do
      visit '/trips/new'
      click_button "Create Trip"

      page.should have_content "Cart Recommendations"
    end
  end

end