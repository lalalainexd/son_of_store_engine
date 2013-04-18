class ProductsController < ApplicationController
  #load_and_authorize_resource
  #skip_authorize_resource :except => [ :new, :create, :show ]

  def index
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
    @product = current_store.products.find(params[:id])

    if @product.retired == true
      redirect_to home_show_path
    else
      render :show
    end
  end

end
