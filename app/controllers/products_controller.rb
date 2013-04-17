class ProductsController < ApplicationController
  #load_and_authorize_resource
  #skip_authorize_resource :except => [ :new, :create, :show ]

  def index

   # @dashboard = Dashboard.new
   # render :index
    @store = Store.find(params[:store_id])
    if @store.disabled?
      render(file: "#{Rails.root}/public/maintenance", formats: :html, status: 404)
    elsif @store
      @products = @store.products.order("name").active
      @categories = @products.collect(&:categories).flatten.to_set
    else
      redirect_to root_path, notice: "Sorry but that doesn't store doesn't exist. Perhaps you should create it?"
    end
  end

  def show
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
