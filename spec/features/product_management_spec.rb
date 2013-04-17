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

  background do
    product1.categories << category
    product2.categories << category

    page.set_rack_session(user_id: admin.id)
    store.add_admin(admin)
    visit admin_products_path(store)

  end

  scenario "Admin views admin listing of products" do

    expect(page).to have_content(product1.name)
    expect(page).to have_content(product2.name)

  end

  scnario "Admin adds a product" do

  end

end
