require 'spec_helper'

describe ProductsController do

  let(:product) {
    Product.new.tap do |product|
    product.name = "thing"
      product.description = "retire it"
      product.retired = false
      product.id = 4
      product.store_id = 42
    end
  }

  def valid_attributes
    {name: "Rations", price: 24,
  description: "Good for one 'splorer."}
  end

  def expected_attributes
    {"name" => "Rations",
      "price" => "24",
      "description" => "Good for one 'splorer."}
  end


  before (:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    @controller.stub(:current_ability).and_return(@ability)
    Product.stub(:find).with(product.id.to_s).and_return(product)
  end

  describe "GET show" do
    it "assigns the requested product as @product" do
      get :show, {:id => product.to_param}
      assigns(:product).should eq(product)
    end
  end

  describe "GET new" do
    it "assigns a new product as @product" do
      get :new
      assigns(:product).should be_a_new(Product)
    end
  end

  describe "GET edit" do
    it "assigns the requested product as @product" do
      get :edit, {:id => product.to_param}
      assigns(:product).should eq(product)
    end
  end

  describe "POST create" do
    describe "with valid params and admin access" do

      before (:each) do
        Product.any_instance.should_receive(:save).and_return(true)
        @ability.can :create, Product
      end

      it "assigns a newly created product as @product" do
        post :create, {:product => valid_attributes}
        assigns(:product).should be_a(Product)
      end

      it "redirects to the created product" do
        post :create, {:product => valid_attributes}
        response.should redirect_to(product)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved product as @product" do
        @ability.can :create, Product
        Product.any_instance.should_receive(:save).and_return(false)
        post :create, {:product => { "name" => "invalid value" }}
        assigns(:product).should be_a_new(Product)
      end
    end
  end

  describe "PUT update" do
    before do
      @ability.can :update, Product
    end

    describe "with valid params" do

      before do
        product.stub(:save).and_return(true)
      end

      it "assigns the requested product as @product" do
        put :update, {:id => product.to_param, :product => valid_attributes}
        assigns(:product).should eq(product)
      end

      it "redirects to the product" do
        put :update, {:id => product.to_param, :product => valid_attributes}
        expect(response).to redirect_to(product_path(product))
        expect(flash.notice).to include("success")
      end
    end

    describe "with invalid params" do
      it "assigns the product as @product" do
        # Trigger the behavior that occurs when invalid params are submitted
        product.stub(:save).and_return(false)
        put :update, {:id => product.to_param, :product => { "name" => "invalid value" }}
        assigns(:product).should eq(product)
      end
    end
  end

  describe "DELETE destroy" do
    before (:each) do
      @ability.can :destroy, Product
      Product.stub(:find).with(product.to_param).and_return(product)
      product.should_receive(:destroy)
    end

    it "redirects to the products list" do
      delete :destroy, {:id => product.to_param}
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
      Product.stub_chain(:order, :active).and_return([product])
      get :list
      assigns(:products).should eq([product])
    end
  end
end
