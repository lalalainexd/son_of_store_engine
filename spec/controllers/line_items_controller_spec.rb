require 'spec_helper'

describe LineItemsController do

  let(:product) { Product.create(:name => "Test") }
  let(:cart) { Cart.create }

  def valid_attributes
    { product_id: product.id, cart_id: cart.id }
  end

  def valid_session
    {}
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new LineItem" do
        expect {
          post :create, {product_id: product.id}, valid_session
        }.to change(LineItem, :count).by(1)
      end

      it "assigns a newly created line_item as @line_item" do
        post :create, {product_id: product.id}, valid_session
        assigns(:line_item).should be_a(LineItem)
        assigns(:line_item).should be_persisted
      end

      it "redirects to the created line_item" do
        post :create, {product_id: product.id}, valid_session
        response.should redirect_to(LineItem.last.cart)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved line_item as @line_item" do
        LineItem.any_instance.stub(:save).and_return(false)
        post :create, { "product_id" => product.id }, valid_session
        assigns(:line_item).should be_a_new(LineItem)
      end

      it "re-renders the 'new' template" do
        LineItem.any_instance.stub(:save).and_return(false)
        post :create, { "product_id" => product.id }, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested line_item" do
      line_item = LineItem.create!(product_id: product.id, cart_id: cart.id)
      expect {
        delete :destroy, {:id => line_item.to_param}, valid_session
      }.to change(LineItem, :count).by(-1)
    end
  end
end
