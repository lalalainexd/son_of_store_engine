require 'spec_helper'

describe LineItemsController do

  let(:product) { Product.create(:name => "Test") }
  let(:cart) { Cart.create }

  def valid_attributes
    { product_id: product.id, cart_id: cart.id }
  end

  describe "POST create" do
    let(:product) {stub(:product, id: 1)}
    let(:line_item) {LineItem.new}

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
      line_item = LineItem.new
      Cart.any_instance.stub_chain(:line_items, :find).and_return(line_item)
      line_item.should_receive(:destroy)
      delete :destroy, {:id => 3}
    end
  end

  describe "PUT commands" do
    before (:each) do
      @request.env['HTTP_REFERER'] = 'http://localhost:3000/'
    end

    describe "quantity" do
      it "increases quantity" do
        cart.add_product(product)
        expect{
          put :increase, :id => 1
        }.to change{cart.line_items.first.quantity}.by(1)
      end

      it "decreases quantity" do
        cart.add_product(product, 3)
        expect{
          put :decrease, :id => 1
        }.to change{cart.line_items.first.quantity}.by(-1)
      end

      it "deletes quantity" do
        cart.add_product(product,1)
        put :decrease, :id => 1
        expect(cart.line_items.count).to eq(0)
      end
    end
  end
end
