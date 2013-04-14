class ProductsController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :except => [ :new, :create, :show ]

  def index

   # @dashboard = Dashboard.new
   # render :index
    store = Store.find(params[:id])
    @products = store.products.order("name").active
    @categories = @products.collect(&:categories).flatten.to_set
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
    @product = Product.find(params[:id])

    if @product.retired == true
      redirect_to home_show_path
    else
      render :show
    end
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])

    @categories = Category.all
  end

  def create
    @product = Product.new(params[:product])

    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def update
    @product = Product.find(params[:id])

    params[:product][:retired] ||= []
    params[:product][:category_ids] ||= []
    @product = Product.find(params[:id])

    if @product.update_attributes(params[:product])
      redirect_to product_path(@product), notice: 'Product was successfully updated.'
    else
      flash[:error] = 'Product was not updated'
      redirect_to product_path(@product)
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to products_url
  end
end
