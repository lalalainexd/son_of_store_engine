require 'spec_helper'

feature "Store administrator removes a stocker", %q{
  Given I am a store administrator of 'http://storeengine.com/cool-sunglasses'
  And I visit 'http://storeengine.com/cool-sunglasses/admin'
  And there is another admin with email "foo@bar.com"
}do

  let(:admin) {FactoryGirl.create(:user)}
  let(:stocker) {FactoryGirl.create(:user, email: "bar@bar.com")}
  let(:store) {FactoryGirl.create(:store, name: "Cool Sunglasses",
                                 slug:"cool-sunglasses", status: "enabled")}

  let(:delay) {stub(:delay)}

  background do
    store.add_admin(admin)
    store.add_stocker(stocker)
    page.set_rack_session(user_id: admin.id)

    visit admin_home_path(store)
  end

  scenario "Removing a stocker", js: true do
    UserMailer.stub(:delay).and_return(delay)
    delay.should_receive(:remove_stocker_notification).with(stocker, store)
    click_button("Remove Stocker")

    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content("The stocker has been removed")
  end

  scenario "Not removing a stocker", js: true do
    click_button("Remove Stocker")
    page.driver.browser.switch_to.alert.dismiss

    within("#stockers") do
      expect(page).to have_content(stocker.email)
    end
  end

end
