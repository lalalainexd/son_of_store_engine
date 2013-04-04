require 'spec_helper'

describe OrdersController do
  let(:user) {User.create(email: "josh@example.com", role: "user")}

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

  describe "GET show" do
    it "assigns the requested order as @order" do
      order = Order.create! valid_attributes
      get :show, {:id => order.to_param}
      assigns(:order).should eq(order)
    end
  end

  describe "GET edit" do
    it "assigns the requested order as @order" do
      order = Order.create! valid_attributes
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
    describe "with valid params and logged in" do
      before(:each) do
        login_user(user)
      end
    end

    describe "with invalid params" do
      before(:each) do
        login_user(user)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Order.any_instance.stub(:save).and_return(false)
        post :create, {:order => { "status" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested order" do
        order = Order.create! valid_attributes
        # Assuming there are no other orders in the database, this
        # specifies that the Order created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Order.any_instance.should_receive(:update_attributes).with({ "status" => "MyString" })
        put :update, {:id => order.to_param, :order => { "status" => "MyString" }}
      end

      it "assigns the requested order as @order" do
        order = Order.create! valid_attributes
        put :update, {:id => order.to_param, :order => valid_attributes}
        assigns(:order).should eq(order)
      end

      it "redirects to the order" do
        order = Order.create! valid_attributes
        put :update, {:id => order.to_param, :order => valid_attributes}
        response.should redirect_to(order)
      end
    end

    describe "with invalid params" do
      it "assigns the order as @order" do
        order = Order.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Order.any_instance.stub(:save).and_return(false)
        put :update, {:id => order.to_param, :order => { "status" => "invalid value" }}
        assigns(:order).should eq(order)
      end

      it "re-renders the 'edit' template" do
        order = Order.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Order.any_instance.stub(:save).and_return(false)
        put :update, {:id => order.to_param, :order => { "status" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested order" do
      order = Order.create! valid_attributes
      expect {
        delete :destroy, {:id => order.to_param}
      }.to change(Order, :count).by(-1)
    end

    it "redirects to the orders list" do
      order = Order.create! valid_attributes
      delete :destroy, {:id => order.to_param}
      response.should redirect_to(orders_path)
    end
  end

end
