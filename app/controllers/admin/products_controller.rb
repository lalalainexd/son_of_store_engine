class Admin::ProductsController < ApplicationController

#  load_and_authorize_resource

  def index
    @dashboard = Dashboard.new(current_store, current_user)
  end

  def new
    @product = current_store.products.build
  end

  def edit
    @product = current_store.products.find(params[:id])

    @categories = Category.all
  end

  def create
    @product = current_store.products.new(params[:product])

    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def update
    @product = current_store.products.find(params[:id])

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
    @product = current_store.products.find(params[:id])
    @product.destroy

    redirect_to products_url
  end

  def show
    @product = current_store.products.find(params[:id])

    if @product.retired == true
      redirect_to home_show_path
    else
      render :show
    end
  end

  def retire
    product = current_store.products.find(params[:id])
    product.retired = true
    product.save

    redirect_to admin_path
  end

  def unretire
    product = current_store.products.find(params[:id])
    product.retired = false
    product.save

    redirect_to admin_path
  end

  private

  def current_store
    @current_store ||= Store.find(params[:store_id])

  end

end
