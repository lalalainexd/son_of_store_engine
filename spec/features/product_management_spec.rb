require 'spec_helper'

feature "Store administrator works with products as in StoreEngine", %q{
  Given I am an admin for the store "Cool Sunglasses"
  And there are products in stock fro my store
  And I am viewing "http://storenegine.com/cool-sunglasses/admin/products"
}do

  let!(:store){FactoryGirl.create(:store, name:"Cool Sunglasses",
                                  status: "enabled")}
  let!(:category){FactoryGirl.create(:category, store: store)}
  let!(:product1){FactoryGirl.create(:product, store: store, name:"Big sunglasses")}
  let!(:product2){FactoryGirl.create(:product, store: store, name:"Small sunglasses")}

  let(:admin) {FactoryGirl.create(:user)}
  let(:stocker) {FactoryGirl.create(:user)}

  background do
    product1.categories << category
    product2.categories << category

    page.set_rack_session(user_id: admin.id)
    store.add_admin(admin)
    #store.add_stocker(stocker)
    visit admin_products_path(store)

  end

  scenario "Admin views admin listing of products" do

    expect(page).to have_content(product1.name)
    expect(page).to have_content(product2.name)

  end

  scenario "Admin adds a product" do
    click_link("New")

    fill_in("Name", with: "A Third PRoduct")
    fill_in("Description", with: "this is another prodcut!")
    fill_in("Price", with: 3.50)
    check("product[category_ids][]") #stupid stupuid stupid this is stupid

    click_button("Create Product")

    expect(current_path).to eq admin_products_path(store)
    expect(page).to have_content("Product was successfully created")
  end

  scenario "Admin edits a product" do
    within('table>tbody>tr:first-child') do
      click_link("Edit")
    end

    fill_in("Name", with: "A New Name")
    fill_in("Description", with: "This is a different description")
    fill_in("Price", with: 9001)
    check("product[category_ids][]") #stupid stupuid stupid this is stupid

    click_button("Update Product")

    expect(current_path).to eq admin_products_path(store)
    expect(page).to have_content("Product was successfully updated")
  end

  scenario "Stocker adds a product" do
   # page.set_rack_session(user_id: stocker.id)

    within('table>tbody>tr:first-child') do
      click_link("Retire")
    end

    expect(current_path).to eq admin_products_path(store)
    expect(page).to have_content("Product is now retired")
  end

end
