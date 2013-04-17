class CategoriesController < ApplicationController
  before_filter :current_store, :categories

  def index
    authorize! :manage, @category

    render :index
  end

  def show
    @category = categories.find(params[:id])
    render :show
  end

  def new
    @category = Category.new
    authorize! :create, @category

    render :new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(params[:category])
    authorize! :create, @category

    if @category.save
      redirect_to @category, notice: 'Category was successfully created.'
    end
  end

  def update
    @category = Category.find(params[:id])
    authorize! :update, @category

    if @category.update_attributes(params[:category])
      redirect_to @category, notice: 'Category was successfully updated.'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    authorize! :destroy, @category
    @category.destroy

    redirect_to categories_path
  end

  private
  def current_store
    @current_store ||= Store.find(params[:store_id])
  end

  def categories
    @categories ||= current_store.categories
  end
end
