class CartsController < ApplicationController
  def index
    @carts = Cart.all
  end

  def show
    begin
      @cart = Cart.find(params[:id])
      if @cart != current_cart
        redirect_to root_path
        flash[:error] = "You are not permitted to view that cart."
        return
      end
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid cart #{params[:id]}"
      flash[:error] = "Invalid cart."
      redirect_to root_path
    end
  end

  def new
    @cart = Cart.new

    respond_to do |format|
      format.html
      format.json { render json: @cart }
    end
  end

  def edit
    @cart = Cart.find(params[:id])
  end

  def create
    @cart = Cart.new(params[:cart])

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render json: @cart, status: :created, location: @cart }
      else
        format.html { render action: "new" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
        # We don't use this?
      end
    end
  end

  def update
    @cart = Cart.find(params[:id])

    respond_to do |format|
      if @cart.update_attributes(params[:cart])
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
        # We don't use this?
      end
    end
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy

    respond_to do |format|
      format.html { redirect_to carts_path }
      format.json { head :no_content }
    end
  end

end
