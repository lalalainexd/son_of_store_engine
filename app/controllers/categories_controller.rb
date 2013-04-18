class CategoriesController < ApplicationController
  load_and_authorize_resource
  before_filter :current_store, :categories

  def index
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
    @category = categories.build

    render :new
  end

  def edit
    @category = categories.find(params[:id])
  end

  def create
    @category = categories.build(params[:category])

    if @category.save
      redirect_to store_category_path(@category), notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  def update
    @category = categories.find(params[:id])

    if @category.update_attributes(params[:category])
      redirect_to store_category_path(@category),
        notice: 'Category was successfully updated.'
    else
      redirect_to edit_store_category_path(@category)
    end
  end

  def destroy
    category = categories.find(params[:id])
    category.destroy

    redirect_to store_categories_path
  end

  private
  def categories
    @categories ||= current_store.categories
  end

  def store_category_path(category)
    category_path(category.store, category)
  end

  def store_categories_path
    categories_path(current_store)
  end

  def edit_store_category_path(category)
    edit_category_path(category.store, category)
  end

end
