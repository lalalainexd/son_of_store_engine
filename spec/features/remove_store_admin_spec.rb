require 'spec_helper'

feature "Store administrator removes another admin", %q{
  Given I am a store administrator of 'http://storeengine.com/cool-sunglasses'
  And I visit 'http://storeengine.com/cool-sunglasses/admin'
  And there is another admin with email "foo@bar.com"
}do

  let(:admin) {FactoryGirl.create(:user)}
  let(:other_admin) {FactoryGirl.create(:user, email: "foo@bar.com")}
  let(:store) {FactoryGirl.create(:store, name: "Cool Sunglasses",
                                 slug:"cool-sunglasses", status: "enabled")}

  let(:delay) {stub(:delay)}

  background do
    UserMailer.stub(:delay).and_return(delay)

    store.add_admin(admin)
    store.add_admin(other_admin)
    page.set_rack_session(user_id: admin.id)

    visit admin_home_path(store)
    click_button("Remove Admin")
  end

  scenario "Removing an admin", js: true do
    #delay.should_receive(:new_admin_notification).with(new_admin, store)
    delay.should_receive(:remove_admin_notification).with(other_admin, store)

    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content("The admin has been removed")

    click_button("Add Admin")

    page.set_rack_session(user_id: new_admin.id)
    visit admin_home_path(store)
    expect(current_path).to eq admin_home_path(store)
  end

  scenario "Not removing an admin" do
    page.driver.browser.switch_to.alert.dismiss

    within("#admins") do
      expect(page).to have_content(other_admin.email)
    end
  end

end
