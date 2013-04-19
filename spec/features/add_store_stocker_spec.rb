require 'spec_helper'

feature "Store administrator adds a new stocker", %q{
  Given I am a store administrator of 'http://storeengine.com/cool-sunglasses'
  And I visit 'http://storeengine.com/cool-sunglasses/admin'
  And I click to add a new store stocker
}do

  let(:admin) {FactoryGirl.create(:user)}
  let(:new_stocker) {FactoryGirl.create(:user, email: "foo@bar.com")}
  let(:store) {FactoryGirl.create(:store, name: "Cool Sunglasses",
                                 slug:"cool-sunglasses", status: "enabled")}

  let(:delay) {stub(:delay)}

  background do
    UserMailer.stub(:delay).and_return(delay)

    store.add_admin(admin)
    store.add_stocker(new_stocker)
    page.set_rack_session(user_id: admin.id)

    visit admin_home_path(store)
    click_link("Add a New Stocker")
  end

  scenario "Adding a stocker with a StoreEngine user account" do
    fill_in("Email", with: new_stocker.email)

    delay.should_receive(:new_stocker_notification).with(new_stocker, store)
    click_button("Add Stocker")

    page.set_rack_session(user_id: new_stocker.id)
    visit admin_home_path(store)
    expect(current_path).to eq admin_home_path(store)
  end

  scenario "Adding a stocker without a StoreEngine user account" do
    fill_in("Email", with: "email@email.com")

    delay.should_receive(:signup_notification).with("email@email.com")
    click_button("Add Stocker")
  end

end
