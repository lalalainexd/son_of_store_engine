class ProductsController < ApplicationController
  #load_and_authorize_resource
  #skip_authorize_resource :except => [ :new, :create, :show ]

  def set_current_store
    #reset_session
    if session[:carts] && session[:carts][current_store.id]
      cart_id = session[:carts][current_store.id]
      session[:cart_id] = Cart.find(cart_id).id
    else
      cart = Cart.create
      session[:carts] ||= {}
      session[:carts][current_store.id] = cart.id
      session[:cart_id] = cart.id
    end
  end

  def index
    set_current_store
    @stores = Store.order("name")

    @store = Store.find(params[:store_id])
    if @store.nil? || @store.pending?
      render file: "#{Rails.root}/public/404", formats: :html, status: 404
    elsif @store.disabled?
      render(file: "#{Rails.root}/public/maintenance", formats: :html, status: 404)
    else
      @products = @store.products.order("name").active
      @categories = @store.categories.order("name")
    end
  end

  def list
    set_current_store
    @products = Product.order("name").active
    @categories = Category.all
  end

  def retire
    product = Product.find(params[:id])
    product.retired = true
    product.save

    redirect_to admin_path
  end

  def unretire
    product = Product.find(params[:id])
    product.retired = false
    product.save

    redirect_to admin_path
  end

  def show
    set_current_store
    @product = current_store.products.find(params[:id])

    if @product.retired == true
      redirect_to home_show_path
    else
      render :show
    end
  end

  def current_store
    @current_store ||= Store.find(params[:store_id])
  end

end
