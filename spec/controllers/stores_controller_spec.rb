require 'spec_helper'

describe StoresController do

  def valid_attributes
    { "name" => "MyString", "slug" => "slug" }
  end

  def valid_session
    {}
  end

  let(:user) {FactoryGirl.create(:user)}

  before do
    login_user(user)
  end

  describe "GET index" do
    it "assigns all stores as @stores" do
      store = Store.create! valid_attributes
      get :index, {}, valid_session
      assigns(:stores).should eq([store])
    end
  end

  describe "GET show" do
    it "assigns the requested store as @store" do
      store = Store.create! valid_attributes
      get :show, {:id => store.to_param}, valid_session
      assigns(:store).should eq(store)
    end

    it "sends a not found error for a pending store" do
      store = Store.create! valid_attributes
      get :show, {:id => store.to_param}, valid_session

      expect(response).to be_not_found

    end
  end

  describe "GET new" do
    it "assigns a new store as @store" do
      get :new, {}, valid_session
      assigns(:store).should be_a_new(Store)
    end
  end

  describe "GET edit" do
    it "assigns the requested store as @store" do
      store = Store.create! valid_attributes
      get :edit, {:id => store.to_param}, valid_session
      assigns(:store).should eq(store)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Store" do
        expect {
          post :create, {:store => valid_attributes}, valid_session
        }.to change(Store, :count).by(1)
      end

      it "assigns a newly created store as @store" do
        post :create, {:store => valid_attributes}, valid_session
        assigns(:store).should be_a(Store)
        assigns(:store).should be_persisted
      end

      it "redirects to the created store" do
        post :create, {:store => valid_attributes}, valid_session
        response.should redirect_to(profile_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved store as @store" do
        # Trigger the behavior that occurs when invalid params are submitted
        Store.any_instance.stub(:save).and_return(false)
        post :create, {:store => { "name" => "invalid value" }}, valid_session
        assigns(:store).should be_a_new(Store)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Store.any_instance.stub(:save).and_return(false)
        post :create, {:store => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end

      context "duplicate store name" do
        it "includes a flash message that the name already exists" do
          name = "name"
          Store.create(name: name, slug: "sluasdfasd")
          post :create, {:store => {name: name, slug: "sluggy"}}
          expect(flash[:error]).to include("Name has already been taken")
        end
      end

      context "duplicate slug" do
        it "includes a flash message that the slug already exists" do
          slug = "slug"
          Store.create(slug: slug, name: "blah")
          post :create, {:store => {slug: slug}}
          expect(flash[:error]).to include("Slug has already been taken")
        end
      end

      context "does not have a store name" do
        it "includes a flash message that there is no store name" do
          post :create, {:store => {slug: "slug"}}
          expect(flash[:error]).to include("Name can't be blank")
        end
      end

      context "does not have a store slug" do
        it "includes a flash message that there is no store slug" do
          post :create, {:store => {name: "name"}}
          expect(flash[:error]).to include("Slug can't be blank")
        end
      end

      context "setting an admin for a store" do
        it "sets the current user as a manager for the new store" do
          pending "store isn't being created. figure out why!"
          post :create, {:store => {name: "name"}}
          expect(Store.first.users).to include(user)
        end
      end
    end

  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested store" do
        store = Store.create! valid_attributes
        # Assuming there are no other stores in the database, this
        # specifies that the Store created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Store.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
        put :update, {:id => store.to_param, :store => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested store as @store" do
        store = Store.create! valid_attributes
        put :update, {:id => store.to_param, :store => valid_attributes}, valid_session
        assigns(:store).should eq(store)
      end

      it "redirects to the store" do
        store = Store.create! valid_attributes
        put :update, {:id => store.to_param, :store => valid_attributes}, valid_session
        response.should redirect_to(store)
      end
    end

    describe "with invalid params" do
      it "assigns the store as @store" do
        store = Store.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Store.any_instance.stub(:save).and_return(false)
        put :update, {:id => store.to_param, :store => { "name" => "invalid value" }}, valid_session
        assigns(:store).should eq(store)
      end

      it "re-renders the 'edit' template" do
        store = Store.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Store.any_instance.stub(:save).and_return(false)
        put :update, {:id => store.to_param, :store => { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested store" do
      store = Store.create! valid_attributes
      expect {
        delete :destroy, {:id => store.to_param}, valid_session
      }.to change(Store, :count).by(-1)
    end

    it "redirects to the stores list" do
      store = Store.create! valid_attributes
      delete :destroy, {:id => store.to_param}, valid_session
      response.should redirect_to(stores_path)
    end
  end

end
