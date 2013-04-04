require 'spec_helper'

describe ProductsController do
  let(:p1) {Product.create! name: "Broken toy",
    description: "Should be retired", retired: false}

  def valid_attributes
    {name: "Rations", price: 24,
  description: "Good for one 'splorer."}
  end

  def valid_session
    {}
  end

  before (:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    @controller.stub(:current_ability).and_return(@ability)
  end

  describe "GET show" do
    it "assigns the requested product as @product" do
      product = Product.create! valid_attributes
      get :show, {:id => product.to_param}, valid_session
      assigns(:product).should eq(product)
    end
  end

  describe "GET new" do
    it "assigns a new product as @product" do
      get :new, {}, valid_session
      assigns(:product).should be_a_new(Product)
    end
  end

  describe "GET edit" do
    it "assigns the requested product as @product" do
      product = Product.create! valid_attributes
      get :edit, {:id => product.to_param}, valid_session
      assigns(:product).should eq(product)
    end
  end

  describe "POST create" do
    describe "with valid params and admin access" do
      before (:each) do
        @ability.can :create, Product
      end

      it "creates a new Product" do
        expect {
          post :create, {:product => valid_attributes}, valid_session
        }.to change(Product, :count).by(1)
      end

      it "assigns a newly created product as @product" do
        post :create, {:product => valid_attributes}, valid_session
        assigns(:product).should be_a(Product)
        assigns(:product).should be_persisted
      end

      it "redirects to the created product" do
        post :create, {:product => valid_attributes}, valid_session
        response.should redirect_to(Product.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved product as @product" do
        # Trigger the behavior that occurs when invalid params are submitted
        Product.any_instance.stub(:save).and_return(false)
        post :create, {:product => { "name" => "invalid value" }}, valid_session
        assigns(:product).should be_a_new(Product)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "assigns the requested product as @product" do
        product = Product.create! valid_attributes
        put :update, {:id => product.to_param, :product => valid_attributes}, valid_session
        assigns(:product).should eq(product)
      end

      it "redirects to the product" do
        product = Product.create! valid_attributes
        put :update, {:id => product.to_param, :product => valid_attributes}, valid_session
        response.should redirect_to(root_path)
      end
    end

    describe "with invalid params" do
      it "assigns the product as @product" do
        product = Product.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Product.any_instance.stub(:save).and_return(false)
        put :update, {:id => product.to_param, :product => { "name" => "invalid value" }}, valid_session
        assigns(:product).should eq(product)
      end
    end
  end

  describe "DELETE destroy" do
    before (:each) do
      @ability.can :destroy, Product
    end

    it "destroys the requested product" do
      product = Product.create! valid_attributes
      expect {
        delete :destroy, {:id => product.to_param}, valid_session
      }.to change(Product, :count).by(-1)
    end

    it "redirects to the products list" do
      product = Product.create! valid_attributes
      delete :destroy, {:id => product.to_param}, valid_session
      response.should redirect_to(products_path)
    end
  end
  describe "retire and unretire" do
    before (:each) do
      @ability.can :manage, Product
    end
  end

  describe "GET list" do
    it "assigns all categories as @categories" do
      category = Category.create(name: "test")
      get :list
      assigns(:categories).should eq([category])
    end

    it "assigns active products as @products" do
      product = Product.create(name: "test", retired: false)
      get :list
      assigns(:products).should eq([product])
    end
  end
end
