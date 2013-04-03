class OrdersController < ApplicationController
  def index
    @orders = Order.all
    authorize! :manage, Order

    respond_to do |format|
      format.html
      format.json { render json: @orders }
    end
  end

  def show
    @order = Order.find(params[:id])
    authorize! :read, Order

    respond_to do |format|
      format.html
      format.json { render json: @order }
    end
  end

  def change_status
    order = Order.find(params[:id])
    order.status = params[:status]
    order.save
    redirect_to "/admin"
  end

  def new
    @order = Order.new
    authorize! :create, Order

    respond_to do |format|
      format.html
      format.json { render json: @order }
    end
  end

  def edit
    @order = Order.find(params[:id])
    authorize! :update, Order
  end

  def create
    if current_user == false
      redirect_to login_path, notice: 'You must be logged in to checkout. Please, login or create an account.'
    else
      total_cost = current_cart.calculate_total_cost
      token = params[:order]["stripe_card_token"]
      @order = Order.new(status: "pending", user_id: current_user.id, total_cost: total_cost)
      @order.add_line_items(current_cart)

      respond_to do |format|
        if @order.save_with_payment(token)
          Cart.destroy(session[:cart_id])
          session[:cart_id] = nil
          format.html { redirect_to root_path, notice: 'Thanks! Your order was successfully submitted.' }
          format.json { render json: @order, status: :created, location: @order }
        else
          format.html { render action: "new" }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end
end
