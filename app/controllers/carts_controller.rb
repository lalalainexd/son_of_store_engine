class CartsController < ApplicationController
  def index
    @carts = Cart.all
  end

  def show
#    begin
    @cart = current_cart
   #   unless @cart
   #     redirect_to root_path
   #     flash[:error] = "You are not permitted to view that cart."
   #     return
   #   end
   # rescue ActiveRecord::RecordNotFound
   #   logger.error "Attempt to access invalid cart #{params[:id]}"
   #   flash[:error] = "Invalid cart."
   #   redirect_to root_path
   # end
  end

  def new
    @cart = Cart.new
  end

  def edit
    @cart = Cart.find(params[:id])
  end

  def create
    @cart = Cart.new(params[:cart])

    if @cart.save
      redirect_to @cart, notice: 'Cart was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @cart = Cart.find(params[:id])

    if @cart.update_attributes(params[:cart])
      redirect_to @cart, notice: 'Cart was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy

    redirect_to carts_path
  end

end
