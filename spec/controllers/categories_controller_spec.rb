require 'spec_helper'

describe CategoriesController do
  def valid_attributes
    { "name" => "MyString" }
  end

  let(:slug) {"slug"}

  let(:current_store) { Store.new(slug: slug) }

  before do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    @controller.stub(:current_ability).and_return(@ability)
    @ability.can :manage, Category

    subject.stub(:current_store).and_return(current_store)
  end

  describe "GET index" do
    it "assigns all categories as @categories" do
      categories = []
      get :index, store_id: slug
      assigns(:categories).should eq(categories)
    end
  end

  describe "GET show" do
    it "assigns the requested category as @category" do
      category = FactoryGirl.create(:category)
      categories = stub(:categories, order: categories)
      categories.should_receive(:order).with("name").and_return(categories)
      categories.should_receive(:find).with("1").and_return(category)
      subject.should_receive(:categories).at_least(:twice).and_return(categories)
      get :show, {store_id: slug, :id => 1}
      assigns(:category).should eq(category)
    end
  end

  describe "GET new" do
    it "assigns a new category as @category" do
      get :new, {store_id: slug}
      assigns(:category).should be_a_new(Category)
    end
  end

  describe "GET edit" do
    it "assigns the requested category as @category" do
      category = FactoryGirl.create(:category)
      categories = stub(:categories)
      categories.should_receive(:find).with(category.id.to_s).and_return(category)
      subject.should_receive(:categories).twice.and_return(categories)
      get :edit, {store_id: slug, id: category.id}
      assigns(:category).should eq(category)
    end
  end

  describe "POST create" do

    let(:category) {Category.new}

    before do
      @ability.can :create, Category
      categories = stub(:categories)
      categories.should_receive(:build).and_return(category)
      subject.stub(:categories).and_return(categories)
    end

    context "with valid params and admin access" do

      before do
        category.should_receive(:save).and_return(true)
      end

      it "redirects to the created category" do
        subject.should_receive(:store_category_path).with(category).and_return(root_path)
        post :create, {store_id: slug, category: valid_attributes}
      end

    end

    context "with invalid params" do
      it "assigns a newly created but unsaved category as @category" do
        # Trigger the behavior that occurs when invalid params are submitted
        category.stub(:save).and_return(false)
        post :create, {store_id: slug,
          :category => { "name" => "invalid value" }}
        assigns(:category).should be_a_new(Category)
      end
    end
  end

  describe "PUT update" do

    let(:category) {FactoryGirl.create(:category)}

    before do

      categories = stub(:categories)
      categories.should_receive(:find).with(category.id.to_s).and_return(category)
      subject.stub(:categories).and_return(categories)
    end

    context "with valid params and admin access" do

      before do
        @ability.can :update, Category

        category.should_receive(:update_attributes).and_return(true)
        subject.should_receive(:store_category_path).with(category).and_return(root_path)
       end

      it "assigns the requested category as @category" do
        put :update, {store_id: slug, id: category.id, category: valid_attributes}
        assigns(:category).should eq(category)
      end

    end

    describe "with invalid params" do

      it "assigns the category as @category" do

        category.stub(:update_attributes).and_return(false)
        put :update, {store_id: slug, :id => category.id, :category => { "name" => "invalid value" }}
        assigns(:category).should eq(category)
      end
    end
  end

  describe "DELETE destroy" do
    let(:category) {FactoryGirl.create(:category)}
    before do
      @ability.can :destroy, Category
    end

    it "destroys the requested category" do
      category.should_receive(:destroy)
      categories = stub(:categories)
      categories.should_receive(:find).with(category.id.to_s).and_return(category)
      subject.should_receive(:categories).at_least(:twice).and_return(categories)
      subject.should_receive(:store_categories_path).and_return(root_path)

      delete :destroy, {store_id: slug, id: category.id }
    end

  end

end
