class StoresController < ApplicationController
  load_and_authorize_resource

  def new
    @store = Store.new
  end

  def edit
    @store = Store.find(params[:id])
  end

  def create
    if @store.save && @store.add_admin(current_user)
      current_user.reload
      redirect_to profile_path, notice: 'Store was successfully created.'
    else
      flash[:error] = @store.errors.full_messages
      render action: "new"
    end
  end

  def update
    @store = Store.find(params[:id])

    if @store.update_attributes(params[:store])
      redirect_to @store, notice: 'Store was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @store = Store.find(params[:id])
    @store.destroy

    redirect_to stores_path
  end

end
