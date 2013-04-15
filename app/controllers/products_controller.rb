class ProductsController < ApplicationController
  #load_and_authorize_resource
  #skip_authorize_resource :except => [ :new, :create, :show ]

  def index

   # @dashboard = Dashboard.new
   # render :index
    store = Store.find(params[:store_id])
    if store
    @products = store.products.order("name").active
    @categories = @products.collect(&:categories).flatten.to_set
    else
      redirect_to root_path, notice: "Sorry but that doesn't store doesn't exist. Perhaps you should create it?"
    end
  end

  def list
    @products = Product.order("name").active
    @categories = Category.all
  end

  def show
    @product = Product.find(params[:id])

    if @product.retired == true
      redirect_to home_show_path
    else
      render :show
    end
  end

end
