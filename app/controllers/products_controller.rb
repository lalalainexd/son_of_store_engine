class ProductsController < ApplicationController
  #load_and_authorize_resource
  #skip_authorize_resource :except => [ :new, :create, :show ]

  def index
    store = Store.find(params[:store_id])
    if store && (store.approved? || store.enabled?)
    @products = store.products.order("name").active
    @categories = @products.collect(&:categories).flatten.to_set
    else
      render file: "#{Rails.root}/public/404.html", status: 404
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

  def current_store
    @current_store ||= Store.find(params[:store_id])
  end

end
