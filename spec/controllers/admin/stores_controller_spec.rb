require 'spec_helper'

describe Admin::StoresController do

  def valid_attributes
    { "name" => "MyString", "slug" => "slug", "status" => "pending" }
  end

  let(:platform_admin) { User.create( { full_name: "Jane Doe",
                                        email: "test@example.com",
                                        platform_administrator: false} )}

  before do
    login_user(platform_admin)
  end

  describe "GET index" do
    it "assigns non-declined stores as @stores" do
      store = Store.create! valid_attributes
      get :index
      assigns(:stores).should eq([store])
    end

    it "does not assign declined stores as @stores" do
      store = Store.create!("name" => "MyString", "slug" => "slug", "status" => "declined")
      get :index
      assigns(:stores).should_not eq([store])
    end
  end

  describe "PUT activate" do
    it "changes status to activated if successful" do
      pending "Stupid test doesn't seem to run the code within activate"
      store = Store.create! valid_attributes
      Store.any_instance.stub(:valid?) {true}
      put :activate, {store_id: store}
      expect(response).to redirect_to(admin_stores_path)
      # Why the hell does this freeze my computer?:
      # expect(response).to include("has been approved")
    end

    it "returns error if not successful" do
      pending "This isn't actually testing anything because the activate method isn't being run"
      store = Store.create! valid_attributes
      Store.any_instance.stub(:valid?) {false}
      put :activate, {store_id: store}
    end
  end

end
