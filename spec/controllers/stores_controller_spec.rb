require 'spec_helper'

describe StoresController do

  def valid_attributes
    { "name" => "MyString", "slug" => "slug" }
  end

  def valid_session
    {}
  end

  let(:user) {FactoryGirl.create(:user)}
  let(:store) { FactoryGirl.create(:store, status: "enabled") }

  before do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    @controller.stub(:current_ability).and_return(@ability)
    @ability.can :manage, Store
    store.add_admin(user)
    login_user(user)
  end

  describe "GET new" do
    it "assigns a new store as @store" do
      get :new, {}, valid_session
      assigns(:store).should be_a_new(Store)
    end
  end

  describe "GET edit" do
    it "assigns the requested store as @store" do
      get :edit, {:id => store.to_param}, valid_session
      assigns(:store).should eq(store)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      before do
        Store.any_instance.should_receive(:save).and_return(true)
        Store.any_instance.should_receive(:add_admin).and_return(true)
      end

      it "assigns a newly created store as @store" do
        post :create, {:store => valid_attributes}, valid_session
        assigns(:store).should be_a(Store)
      end

      it "redirects to the user's profile" do
        post :create, {:store => valid_attributes}, valid_session
        response.should redirect_to(profile_path)
      end
    end

    describe "with invalid params" do

      before do
      end

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
          store = Store.new
          store.should_receive(:save).and_return(true)
          store.should_receive(:add_admin).with(user).and_return(true)
          Store.should_receive(:new).with({"name" => "name"}).and_return(store)
          post :create, {store: {name: "name"}}
        end
      end
    end

  end

  describe "PUT update" do

    before do
      @ability = Object.new
      @ability.extend(CanCan::Ability)
      @controller.stub(:current_ability).and_return(@ability)
      @ability.can :update, Store
      login_user(user)
    end

    describe "with valid params" do

      let(:store) { Store.new(slug: "foo")}

      before do
        Store.stub(:find).with("foo").and_return(store)
        store.should_receive(:update_attributes).with(valid_attributes).and_return(true)
      end

      it "assigns the requested store as @store" do
        put :update, {:id => store.to_param, :store => valid_attributes}
        assigns(:store).should eq(store)
      end

      it "redirects to the store" do
        put :update, {:id => store.to_param, :store => valid_attributes}
        response.should redirect_to(store)
      end
    end

    describe "with invalid params" do
      let(:store) { Store.new(slug: "foo")}
      let(:invalid_attributes) {{ "name" => "invalid value" }}

      before do
        Store.stub(:find).with("foo").and_return(store)
        store.should_receive(:update_attributes).with(invalid_attributes).and_return(false)
      end

      it "assigns the store as @store" do
        put :update, {:id => store.to_param, :store => invalid_attributes}
        assigns(:store).should eq(store)
      end

      it "re-renders the 'edit' template" do
        put :update, {:id => store.to_param, :store => invalid_attributes}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do


    it "redirects to the stores list" do
      @ability = Object.new
      @ability.extend(CanCan::Ability)
      @controller.stub(:current_ability).and_return(@ability)
      @ability.can :destroy, Store
      login_user(user)

      store = Store.new(slug: "foo")
      Store.stub(:find).with("foo").and_return(store)
      store.should_receive(:destroy).and_return(true)

      delete :destroy, {:id => store.to_param}
      response.should redirect_to(stores_path)
    end
  end

end
