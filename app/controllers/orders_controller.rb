class OrdersController < ApplicationController
  load_and_authorize_resource :except => [:create, :new, :show]
  skip_authorize_resource :except => [ :new, :create, :show ]

  def index
    @orders = Order.all

    render :index
  end

  def show
    @order = Order.find(params[:id])

    if @order.user && @order.user == current_user
      @user = @order.user
    else
      @user = @order.visitor
    end

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
      redirect_to root_path
    else
      @order = Order.new

      capture_previous_page
      render :new
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def create
    @order = create_order(params)

    if @order.valid?
      deliver_confirmation(@order.owner, @order)
      clear_cart
      redirect_to @order, notice: 'Thanks! Your order was submitted.'
    else
      render action: "new"
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

    redirect_to orders_path
  end

  def deliver_confirmation user, order
    UserMailer.delay.order_confirmation(user, order)
  end

  def clear_cart
    session[:carts].delete(current_cart.store.id)
    current_cart.destroy
    session.delete(:cart_id)
  end

  private

  def authorize_user
    authorize! :manage, Order
  end

  def create_order(params)
    if current_user
      Order.create_from_cart_for_user(current_cart, current_user,
                                      params[:order]["stripe_card_token"])
    else
      Order.create_visitor_order(current_cart,
                                 params[:order][:visitor][:email],
                                 params["stripe_card_token"])
    end

  end

end
