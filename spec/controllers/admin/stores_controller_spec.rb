require 'spec_helper'

describe Admin::StoresController do


  let!(:standard_user) { User.create( { full_name: "John Doe",
                                        email: "john@example.com",
                                        password: "password",
                                        platform_administrator: false} )}

  let(:platform_admin) { User.create( { full_name: "Jane Doe",
                                        email: "test@example.com",
                                        password: "password",
                                        platform_administrator: true} )}


  def valid_attributes
    {
      "name" => "MyString",
      "slug" => "slug",
      "status" => "pending",
    }
  end
  let(:store) { Store.create! valid_attributes }
  before do
    login_user(platform_admin)
    UserStore.create( { user_id: standard_user.id,
                        store_id: store.id,
                        role_id: 1 })
  end

  describe "GET index" do
    it "assigns non-declined stores as @stores" do
      get :index
      assigns(:stores).should eq([store])
    end
  end

  describe "PUT activate" do
    it "changes status to activated if successful" do
      put :activate, {store_id: store}
      expect(response).to redirect_to(admin_stores_path)
    end

    it "returns error if not successful" do
      Store.any_instance.stub(:valid?) {false}
      put :activate, {store_id: store}
      expect(flash[:errors]).to include("We're sorry")
    end
  end

  describe "PUT decline" do
    it "changes status to declined if successful" do
      put :decline, {store_id: store}
      expect(response).to redirect_to(admin_stores_path)
    end

    it "returns error if not successful" do
      Store.any_instance.stub(:decline_status) {false}
      put :decline, {store_id: store}
      expect(flash[:errors]).to include("We're sorry")
    end
  end

  describe "PUT disable" do
    it "changes status to declined if successful" do
      put :disable, {store_id: store}
      expect(response).to redirect_to(admin_stores_path)
    end

    it "returns error if not successful" do
      Store.any_instance.stub(:valid?) {false}
      put :disable, {store_id: store}
      expect(flash[:errors]).to be
    end
  end

  describe "PUT enable" do
    it "changes status to declined if successful" do
      put :enable, {store_id: store}
      expect(response).to redirect_to(admin_stores_path)
    end

    it "returns error if not successful" do
      Store.any_instance.stub(:valid?) {false}
      put :enable, {store_id: store}
      expect(flash[:errors]).to include("We're sorry")
    end
  end
end
