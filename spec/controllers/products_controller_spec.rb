require 'spec_helper'

describe ProductsController do

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
    subject.stub_chain(:current_store, :products, :find).and_return(product)
  end

  describe "GET show" do
    it "assigns the requested product as @product" do
      get :show, {store_id: 42, :id => product.to_param}
      assigns(:product).should eq(product)
    end
  end

end
