require 'spec_helper'

describe OrdersController do
  let(:user) {User.create(full_name: "josh", email: "josh@example.com", role: "user")}

  def valid_attributes
    { "status" => "pending", "user_id" => user.id, "total_cost" => 300 }
  end

  describe "GET index" do
    it "assigns all orders as @orders" do
      order = Order.create! valid_attributes
      get :index, {}
      assigns(:orders).should eq([order])
    end
  end

  describe "GET edit" do
    it "assigns the requested order as @order" do
      order = Order.new(confirmation: "confirmation")
      Order.stub(:find).with("confirmation").and_return(order)
      get :edit, {:id => order.to_param}
      assigns(:order).should eq(order)
    end
  end

  describe "GET new" do
    it "new order without items redirects" do
      get :new, {}, {}
      response.should redirect_to(root_path)
    end
  end

  describe "POST create" do
    let(:checkout_attributes) do
      {
        visitor: {email: "foo@bar.com"},
        "stripe_card_token" => "42"
      }
    end

    context "with valid params" do

      let(:order) {stub(:order, valid?: true, to_param:"order")}
      before do
        subject.should_receive(:deliver_confirmation)
      end

      context "with anonymous user" do

        it "redirects to the order summary" do
          Order.should_receive(:create_visitor_order).with(Cart.any_instance, "foo@bar.com", "42").and_return(order)
          post :create, {order: checkout_attributes}
          expect(response).to redirect_to order_path(order)
        end
      end

      context "with a user" do

        it "redirects to the user's account" do
          login_user(user)
          Order.should_receive(:create_from_cart_for_user).and_return(order)
          post :create, {:order => valid_attributes}
          expect(response).to redirect_to order_path(order)
        end

      end
    end

    context "with invalid params" do
      it "re-renders the 'new' template" do
        order = stub(:order, valid?: false)
        subject.stub(:create_order).and_return(order)
        post :create, {:order => { "status" => "paid" }}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do
    describe "with valid params" do

      let(:order) { Order.new(confirmation: "blah") }

      let(:expected_attributes) {
        { "status" => "pending", "user_id" => user.id, "total_cost" => "300" }
      }
      before do
        Order.stub(:find).with("blah").and_return(order)
        order.should_receive(:update_attributes).with(expected_attributes).and_return(true)
      end

      it "assigns the requested order as @order" do
        put :update, {:id => order.to_param, :order => valid_attributes}
        assigns(:order).should eq(order)
      end

      it "redirects to the order" do
        put :update, {:id => order.to_param, :order => valid_attributes}
        response.should redirect_to(order)
      end
    end

    describe "with invalid params" do
      let(:order) { stub(:order, to_param: "blah", update_attributes: false) }

      before do
        Order.stub(:find).with("blah").and_return(order)
      end

      it "assigns the order as @order" do
        put :update, {:id => order.to_param, :order => { "status" => "invalid value" }}
        assigns(:order).should eq(order)
      end

      it "re-renders the 'edit' template" do
        put :update, {:id => order.to_param, :order => { "status" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do

    let(:order) { stub(:order, to_param: "blah", update_attributes: false) }

    before do
      Order.stub(:find).with("blah").and_return(order)
      order.should_receive(:destroy)
    end

    it "redirects to the orders list" do
      delete :destroy, {:id => order.to_param}
      response.should redirect_to(orders_path)
    end
  end

end
