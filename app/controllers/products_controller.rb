class ProductsController < ApplicationController
  def index
    @categories = Category.all.sort_by {|c| c.name}
    authorize! :manage, @product

    respond_to do |format|
      format.html
      format.json { render json: @products }
    end
  end

  def retire
    product = Product.find(params[:id])
    product.retired = true
    product.save

    redirect_to admin_path
  end

  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @product }
    end
  end

  def new
    @product = Product.new
    authorize! :create, @product

    respond_to do |format|
      format.html
      format.json { render json: @product }
    end
  end

  def edit
    @product = Product.find(params[:id])
    authorize! :update, @product

    @categories = Category.all
  end

  def create
    @product = Product.new(params[:product])
    authorize! :create, @product

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @product = Product.find(params[:id])
    authorize! :update, @product

    params[:product][:retired] ||= []
    params[:product][:category_ids] ||= []
    @product = Product.find(params[:id])
    
    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product = Product.find(params[:id])
    authorize! :destroy, @product
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end
end
