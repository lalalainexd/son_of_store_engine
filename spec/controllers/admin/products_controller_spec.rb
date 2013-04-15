require 'spec_helper'

describe Admin::ProductsController do
  let(:store) {
    Store.new.tap do | store |
    store.name = "name"
    store.slug = "slug"
    store.id = 42
    end
  }

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
    subject.stub(:current_store).and_return(store)
    subject.stub_chain(:current_store, :products, :find).and_return(product)
  end

  describe "GET show" do
    it "assigns the requested product as @product" do
      get :show, {store_id: store.to_param, :id => product.to_param}
      assigns(:product).should eq(product)
    end
  end

  describe "GET new" do
    it "assigns a new product as @product" do
      subject.stub(:current_store).and_return(store)
      get :new, {store_id: store.to_param}
      assigns(:product).should be_a_new(Product)
    end
  end

  describe "GET edit" do
    it "assigns the requested product as @product" do
      get :edit, {store_id: store.to_param, :id => product.to_param}
      assigns(:product).should eq(product)
    end
  end

  describe "POST create" do
    describe "with valid params and admin access" do

      before (:each) do
        Product.any_instance.should_receive(:save).and_return(true)
        subject.stub_chain(:current_store, :products, :build).and_return(product)
        @ability.can :create, Product
      end

      it "assigns a newly created product as @product" do
        post :create, {:store_id => store.to_param, :product => valid_attributes}
        assigns(:product).should be_a(Product)
      end

      it "redirects to the created product" do
        post :create, {:product => valid_attributes, :store_id => store.to_param}
        response.should redirect_to(admin_product_path(store_id: store.to_param, id: product.id))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved product as @product" do
        @ability.can :create, Product
        Product.any_instance.should_receive(:save).and_return(false)
        post :create, {:product => { "name" => "invalid value" }, store_id: store.to_param}
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
        put :update, {:id => product.to_param, :product => valid_attributes,
        :store_id  => store.to_param}
        assigns(:product).should eq(product)
      end

      it "redirects to the product" do
        put :update, {store_id: store.to_param, :id => product.to_param, :product => valid_attributes}
        expect(response).to redirect_to(admin_product_path(store_id: store.to_param,
                                                           id: product.id))
        expect(flash.notice).to include("success")
      end
    end

    describe "with invalid params" do
      it "assigns the product as @product" do
        # Trigger the behavior that occurs when invalid params are submitted
        product.stub(:save).and_return(false)
        put :update, {store_id: store.to_param, :id => product.to_param, :product => { "name" => "invalid value" }}
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
      delete :destroy, {store_id: store.to_param, :id => product.to_param}
      response.should redirect_to(admin_products_path(store))
    end
  end

  describe "retire and unretire" do
    before (:each) do
      @ability.can :manage, Product
    end

    it "retires a product" do
      product.should_receive(:retired=).with(true)
      put :retire, {:store_id => store.to_param, id: product.id}

    end

    it "unretires a product" do
      product.should_receive(:retired=).with(false)
      put :unretire, {:store_id => store.to_param, id: product.id}
    end

  end

end
