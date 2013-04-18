class CategoriesController < ApplicationController
  before_filter :current_store, :categories

  def index
    authorize! :manage, @category

    render :index
  end

  def show
    @store = current_store
    @categories = @store.categories.order("name")
    @stores = Store.order("name")
    @category = categories.find(params[:id])
    render :show
  end

  def new
    @category = Category.new
    authorize! :create, @category

    render :new
  end

  def edit
    @category = categories.find(params[:id])
  end

  def create
    @category = categories.build(params[:category])
    authorize! :create, @category

    if @category.save
      redirect_to store_category_path(@category), notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  def update
    @category = categories.find(params[:id])
    authorize! :update, @category

    if @category.update_attributes(params[:category])
      redirect_to store_category_path(@category),
        notice: 'Category was successfully updated.'
    else
      redirect_to edit_store_category_path(@category)
    end
  end

  def destroy
    category = categories.find(params[:id])
    authorize! :destroy, category
    category.destroy

    redirect_to store_categories_path
  end

  private
  def current_store
    @current_store ||= Store.find(params[:store_id])
  end

  def categories
    @categories ||= current_store.categories
  end

  def store_category_path(category)
    category_path(store_id: current_store.to_param, id: category.id)
  end

  def store_categories_path
    categories_path(store_id: current_store.to_param)
  end

  def edit_store_category_path(category)
    edit_category_path(store_id: current_store.to_param, id: category.id)
  end

end
