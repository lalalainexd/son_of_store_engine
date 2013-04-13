require 'spec_helper'

describe LineItemsController do

  let(:product) { Product.create(:name => "Test") }
    let(:line_item) {LineItem.new}

  def valid_attributes
    { product_id: product.id, cart_id: cart.id }
  end

  describe "POST create" do
    let(:product) {stub(:product, id: 1)}

    before do
      @request.env['HTTP_REFERER'] = 'http://localhost:3000/'
      Product.stub(:find).and_return(product)
      Cart.any_instance.should_receive(:add_product).and_return(line_item)
    end

    describe "with valid params" do
      before do
        line_item.stub(:save).and_return(true)
      end
      it "assigns a newly created line_item as @line_item" do
        post :create, {product_id: product.id}
        assigns(:line_item).should be_a(LineItem)
      end

      it "redirects to the created line_item" do
        post :create, {product_id: product.id}
        response.should redirect_to("http://localhost:3000/")
      end
    end

    describe "with invalid params" do
      before do
        line_item.stub(:save).and_return(false)
      end
      it "assigns a newly created but unsaved line_item as @line_item" do
        post :create, { "product_id" => product.id }
        assigns(:line_item).should be_a_new(LineItem)
      end

      it "re-renders the 'new' template" do
        post :create, { "product_id" => product.id }
        response.should render_template("new")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested line_item" do
      Cart.any_instance.stub_chain(:line_items, :find).and_return(line_item)
      line_item.should_receive(:destroy)
      delete :destroy, {:id => 3}
    end
  end

  describe "PUT commands" do

    before (:each) do
      Cart.any_instance.stub_chain(:line_items, :find).and_return(line_item)
    end

    context "increase_quantity" do

      it "increases quantity of the line item" do
        line_item.should_receive(:increase_quantity).and_return(true)
        put :increase, :id => 1
      end

    end

    context "decrease_quantity" do

      it "decreases quantity of the line item" do
        line_item.stub(:quantity).and_return(3)
        line_item.should_receive(:decrease_quantity).and_return(false)
        put :decrease, :id => 1
      end

      it "deletes the item" do
        line_item.stub(:quantity).and_return(1)
        line_item.should_receive(:delete)
        put :decrease, :id => 1
      end
    end

  end
end
