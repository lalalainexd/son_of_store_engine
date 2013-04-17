require 'spec_helper'

describe "Platform Admin declining and approving a new store" do

  let!(:platform_admin) { User.create!(full_name: "Mr. Admin",
                                      email: "admin@example.com",
                                      password: "password",
                                      platform_administrator: true)}

  let!(:store_admin) { User.create!(full_name: "Mrs. Store Admin",
                                      email: "storeadmin@example.com",
                                      password: "password",
                                      platform_administrator: false)}

  let!(:store) { Store.create!(name: "Cool Runnings",
                               slug: "cool-runnings",
                               status: "pending") }

  let!(:role) { Role.create!(title: "admin") }


  context "StoreEngine admin declines a new store" do
    it "displays a message confirming deletion" do
      UserStore.create!(user_id: store_admin.id, store_id: store.id, role_id: role.id)
      visit '/login'
      fill_in 'email', with: platform_admin.email
      fill_in 'password', with: 'password'
      click_button "Log in"

      visit admin_stores_path
      #delayed_job = mock('Delayed Job')
      #UserMailer.should_receive(:delay) { delayed_job }

      #delayed_job.should_receive(:store_decline_notification).with('test@example.com', 'Cool Runnings')
      click_link "Decline"
      find('.alert-success').should be_visible

      page.should have_content("Cool Runnings has been set to 'declined'")
    end
  end

  context "StoreEngine admin approves a new store" do
    it "displays a message confirming deletion" do
      UserStore.create!(user_id: store_admin.id, store_id: store.id, role_id: role.id)
      visit '/login'
      fill_in 'email', with: platform_admin.email
      fill_in 'password', with: 'password'
      click_button "Log in"

      visit admin_stores_path
      click_link "Approve"
      find('.alert-success').should be_visible

      page.should have_content("Cool Runnings has been approved")
    end
  end
end
