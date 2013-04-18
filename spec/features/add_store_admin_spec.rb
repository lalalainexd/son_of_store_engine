require 'spec_helper'

feature "Store administrator adds a new admin", %q{
  Given I am a store administrator of 'http://storeengine.com/cool-sunglasses'
  And I visit 'http://storeengine.com/cool-sunglasses/admin'
  And I click to add a new store admin
}do

  let(:admin) {FactoryGirl.create(:user)}
  let(:new_admin) {FactoryGirl.create(:user, email: "foo@bar.com")}
  let(:store) {FactoryGirl.create(:store, name: "Cool Sunglasses",
                                 slug:"cool-sunglasses", status: "enabled")}

  let(:delay) {stub(:delay)}

  background do
    UserMailer.stub(:delay).and_return(delay)

    store.add_admin(admin)
    page.set_rack_session(user_id: admin.id)

    visit admin_home_path(store)
    click_link("Add a New Admin")
  end

  scenario "Adding an admin with a StoreEngine user account" do
    fill_in("Email", with: new_admin.email)

    delay.should_receive(:new_admin_notification).with(new_admin, store)
    click_button("Add Admin")

    page.set_rack_session(user_id: new_admin.id)
    visit admin_home_path(store)
    expect(current_path).to eq admin_home_path(store)
  end

  scenario "Adding an admin without a StoreEngine user account" do
    fill_in("Email", with: "email@email.com")

    delay.should_receive(:invite_notification).with("email@email.com")
    click_button("Add Admin")
  end

end
