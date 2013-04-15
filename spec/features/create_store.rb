require 'spec_helper'

feature "StoreEngine user creates a new store", %q{
  Given I am a logged in StoreEngine user
  And I visit "http://storeengine.com/profile"
  Then I should be able to click to create a new store
  } do


  let(:user) {FactoryGirl.create(:user)}

  background do
    page.set_rack_session(user_id: user.id)
    visit profile_path

    click_link("Create New Store")
  end

  scenario "Creating store" do
    FactoryGirl.create(:store,
                       name: "Best Sunglasses",
                       slug: "best-sunglasses")

    #Attempt to create a store with duplicate name
    fill_in("Name", with: "Best Sunglasses")
    fill_in("Slug", with: "sunglasses")
    fill_in("Description", with: "Buy our sunglasses!")

    click_button("Create")

    expect(page).to have_content("Name has already been taken")
    expect(page.find_field("Name")).to be
    expect(page.find_button("Create")).to be

    #Attempt to create a store with duplicate slug
    fill_in("Name", with: "Best Sunglasses2")
    fill_in("Slug", with: "best-sunglasses")
    fill_in("Description", with: "Buy our sunglasses!")

    click_button("Create")

    expect(page).to have_content("Slug has already been taken")
    expect(page.find_field("Name")).to be
    expect(page.find_button("Create")).to be

    #Creating a new store with a unique name and slug
    fill_in("Name", with: "Cool Sunglasses")
    fill_in("Slug", with: "cool-sunglasses")
    fill_in("Description", with: "Buy our sunglasses!")

    click_button("Create")

    expect(current_path).to eq profile_path
    expect(page).to have_content("Store was successfully created")
    expect(page).to have_content("pending")

    #Visiting the newly created store
    visit home_path("cool-sunglasses")
    puts current_path
    expect(page).to have_content("The page you were looking for doesn't exist")
    expect(status_code).to eq 404
  end

end

