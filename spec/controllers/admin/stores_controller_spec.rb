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
    role = Role.create!( { title: "test" } )
    UserStore.create!( { user_id: standard_user.id,
                        store_id: store.id,
                        role_id: role.id })
  end


  describe "GET index" do
    it "assigns non-declined stores as @stores" do
      get :index
      assigns(:stores).should eq([store])
    end
  end

  describe "PUT activate" do
    it "changes status to activated if successful" do
      #mail = stub(:mail, deliver: "")
      delay = stub(:delay)
      delay.should_receive(:store_approval_confirmation)
      UserMailer.should_receive(:delay).and_return(delay)
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
      store.should_receive(:decline_status).and_return(true)
      delay = stub(:delay)
      delay.should_receive(:store_decline_notification)
      UserMailer.should_receive(:delay).and_return(delay)
      store.should_receive(:users).and_return([standard_user])
      Store.stub(:find).and_return(store)
      #store = mock('Store', name: 'My Store')
      #Store.stub(:find) { store }
      #store.stub(:users) { [platform_admin] }

      #store.should_receive(:decline_status) { false }

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

describe Admin::StoresController do
  context "adding an admin" do
    let!(:standard_user) { User.create( { full_name: "John Doe",
                                          email: "john@example.com",
                                          password: "password",
                                          platform_administrator: false} )}

    let(:store) { Store.new}
    before do
      @ability = Object.new
      @ability.extend(CanCan::Ability)
      @controller.stub(:current_ability).and_return(@ability)
      @ability.can :create_admin, Store
      login_user(standard_user)
      UserStore.create( { user_id: standard_user.id,
                          store_id: store.id,
                          role_id: 1 })
      Store.should_receive(:find).with("slug").and_return(store)
    end

    it "adds an admin" do
      user = User.new( { full_name: "Austen Ito",
                         email: "austen@ito.com",
                         password: "password",
                         platform_administrator: false} )

      User.should_receive(:find_by_email).with(user.email).and_return(user)
      store.should_receive(:add_admin).with(user)
      post :create_admin, store_id: "slug", email: user.email
    end
  end
end
