class OrdersController < ApplicationController
  def index
    @orders = Order.all
    authorize! :manage, Order

    render :index
  end

  def show
    @order = Order.find(params[:id])
    authorize! :read, Order

    render :show
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

    render :new
  end

  def edit
    @order = Order.find(params[:id])
    authorize! :update, Order
  end

  def create
<<<<<<< HEAD
    unless current_user
      flash[:error] = 'You must log in to checkout. Please, login or signup.'
      redirect_to login_path and return
    end

    if Order.create_from_cart_for_user(current_cart, current_user, params[:order]["stripe_card_token"])
      current_cart.destroy
      session[:cart_id] = nil
      redirect_to root_path, notice: 'Thanks! Your order was submitted.'
    else
      render action: "new"
    end
=======
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
>>>>>>> stripe
    end
  end

  def update
    @order = Order.find(params[:id])

    if @order.update_attributes(params[:order])
      redirect_to @order, notice: 'Order was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    redirect_to orders_url
  end
end
