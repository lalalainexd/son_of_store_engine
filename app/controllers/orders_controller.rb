class OrdersController < ApplicationController
  def index
    @orders = Order.all
    authorize! :manage, Order

    render :index
  end

  def show
    @order = Order.find(params[:id])

    if @order.user
      @user = @order.user
    else
      @user = @order.visitor
    end
    #authorize! :manage, Order

    render :show

  end

  def change_status
    order = Order.find(params[:id])
    order.status = params[:status]
    order.save
    redirect_to "/admin"
  end

  def new
    if current_cart.calculate_total_cost <= 50
      flash[:error] =
        "Sorry Partner. Your cart must contain at least $0.51 worth of goods."
      redirect_to root_path and return
    end
    @order = Order.new
    authorize! :create, Order

    render :new
  end

  def edit
    @order = Order.find(params[:id])
    authorize! :update, Order
  end

  def create
    if current_user
      order = Order.create_from_cart_for_user(current_cart,
                                                 current_user,
                                                 params[:order]["stripe_card_token"])

      if order.valid?
        deliver_confirmation(current_user, order)
        current_cart.destroy
        session[:cart_id] = nil
        redirect_to root_path, notice: 'Thanks! Your order was submitted.'
      else
        render action: "new"
      end
    else
      order = Order.create_visitor_order(current_cart,
                                         params[:order][:visitor][:email],
                                         params[:order]["stripe_card_token"])
      if order.valid?
        deliver_confirmation(order.visitor, order)
        clear_cart
        redirect_to root_path, notice: 'Thanks! Your order was submitted.'
      else
        render action: "new"
      end

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

  def deliver_confirmation user, order
    UserMailer.order_confirmation(user, order).deliver
  end

  def clear_cart
    current_cart.destroy
    session[:cart_id] = nil
  end
end
