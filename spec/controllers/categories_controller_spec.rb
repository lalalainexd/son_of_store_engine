require 'spec_helper'

describe CategoriesController do
  def valid_attributes
    { "name" => "MyString" }
  end
    let(:current_store) { Store.new }
    let(:slug) {"slug"}

  before (:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    @controller.stub(:current_ability).and_return(@ability)

    Store.should_receive(:find).with(slug).and_return(current_store)
  end

  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all categories as @categories" do
      categories = []
      current_store.should_receive(:categories).and_return(categories)
      get :index, store_id: slug
      assigns(:categories).should eq(categories)
    end
  end

  describe "GET show" do
    it "assigns the requested category as @category" do
      category = stub(:category)
      categories = stub(:categories)
      categories.should_receive(:find).with("1").and_return(category)
      subject.should_receive(:categories).twice.and_return(categories)
      get :show, {store_id: slug, :id => 1}, valid_session
      assigns(:category).should eq(category)
    end
  end

  describe "GET new" do
    it "assigns a new category as @category" do
      get :new, {store_id: slug}, valid_session
      assigns(:category).should be_a_new(Category)
    end
  end

  describe "GET edit" do
    it "assigns the requested category as @category" do
      category = Category.create! valid_attributes
      get :edit, {:id => category.to_param}, valid_session
      assigns(:category).should eq(category)
    end
  end

  describe "POST create" do
    context "with valid params and admin access" do
      before (:each) do
        @ability.can :create, Category
      end

      it "creates a new Category" do
        expect {
          post :create, {:category => valid_attributes}, valid_session
        }.to change(Category, :count).by(1)
      end

      it "assigns a newly created category as @category" do
        post :create, {:category => valid_attributes}, valid_session
        assigns(:category).should be_a(Category)
        assigns(:category).should be_persisted
      end

      it "redirects to the created category" do
        post :create, {:category => valid_attributes}, valid_session
        response.should redirect_to(Category.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved category as @category" do
        # Trigger the behavior that occurs when invalid params are submitted
        Category.any_instance.stub(:save).and_return(false)
        post :create, {:category => { "name" => "invalid value" }}, valid_session
        assigns(:category).should be_a_new(Category)
      end
    end
  end

  describe "PUT update" do
    context "with valid params and admin access" do
    before (:each) do
      @ability.can :update, Category
    end

      it "assigns the requested category as @category" do
        category = Category.create! valid_attributes
        put :update, {:id => category.to_param, :category => valid_attributes}, valid_session
        assigns(:category).should eq(category)
      end

      it "redirects to the category" do
        category = Category.create! valid_attributes
        put :update, {:id => category.to_param, :category => valid_attributes}, valid_session
        response.should redirect_to(category)
      end
    end

    describe "with invalid params" do
      it "assigns the category as @category" do
        category = Category.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Category.any_instance.stub(:save).and_return(false)
        put :update, {:id => category.to_param, :category => { "name" => "invalid value" }}, valid_session
        assigns(:category).should eq(category)
      end
    end
  end

  describe "DELETE destroy" do
    before (:each) do
      @ability.can :destroy, Category
    end

    it "destroys the requested category" do
      category = Category.create! valid_attributes
      expect {
        delete :destroy, {:id => category.to_param}, valid_session
      }.to change(Category, :count).by(-1)
    end

    it "redirects to the categories list" do
      category = Category.create! valid_attributes
      delete :destroy, {:id => category.to_param}, valid_session
      response.should redirect_to(categories_path)
    end
  end

end
