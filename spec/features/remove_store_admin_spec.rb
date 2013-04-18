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
    store.add_admin(admin)
    store.add_admin(other_admin)
    page.set_rack_session(user_id: admin.id)

    visit admin_home_path(store)
  end

  scenario "Removing an admin", js: true do
    UserMailer.stub(:delay).and_return(delay)
    delay.should_receive(:remove_admin_notification).with(other_admin, store)
    click_button("Remove Admin")

    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content("The admin has been removed")
  end

  scenario "Removing the last", js: true do
    store.remove_admin(admin)
    admin.platform_administrator = true
    admin.save
    click_button("Remove Admin")

    page.driver.browser.switch_to.alert.accept
    within("#admins") do
      expect(page).to have_content(other_admin.email)
    end
  end

  scenario "Not removing an admin", js: true do
    click_button("Remove Admin")
    page.driver.browser.switch_to.alert.dismiss

    within("#admins") do
      expect(page).to have_content(other_admin.email)
    end
  end

end
