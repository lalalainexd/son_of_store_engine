require 'spec_helper'

feature "Platform Administrator approves a new store", %q{
  Given I am a Platform Administrator
  And a store "Cool Runnings" has been created
  And is pending approval
  And I visit "http://storenegine.com/admin/stores"
  } do


  let(:platform_admin) {FactoryGirl.create(:platform_admin)}
  let(:store) { FactoryGirl.create(:store, name:"Cool Runnings")}
  let(:user) { FactoryGirl.create(:user)}

  background do
    store.add_admin(user)
    page.set_rack_session(user_id: platform_admin.id)
    visit admin_stores_path

  end

  scenario "StoreEngine admin approves a new store" do
    UserMailer.any_instance.should_receive(:store_approval_confirmation)
    click_link("Approve")

    expect(page).to have_content("Cool Runnings")
    expect(page).to have_content("Cool Runnings has been approved")
    expect(page).to_not have_link("Approve")
    expect(page).to_not have_link("Decline")
  end

  scenario "StoreEngine admin approves a new store" do
    UserMailer.any_instance.should_receive(:store_decline_notification)
    click_link("Decline")

    expect(page).to have_content("Cool Runnings has been set to 'declined'")
    expect(page).to_not have_link("Approve")
    expect(page).to_not have_link("Decline")
  end
end

