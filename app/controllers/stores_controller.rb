class StoresController < ApplicationController
  load_and_authorize_resource :except => :show

  def show
    @store = Store.find(params[:id])
    if @store.pending?
      render file: "#{Rails.root}/public/404.html", status: 404
    end
  end

  def new
    @store = Store.new
  end

  def edit
    @store = Store.find(params[:id])
  end

  def create
    @store = Store.new(params[:store])
    @store.add_admin(current_user)

    if @store.save
      redirect_to profile_path, notice: 'Store was successfully created.'
    else
      flash[:error] = @store.errors.full_messages
      render action: "new"
    end
  end

  def update
    @store = Store.find(params[:id])

    respond_to do |format|
      if @store.update_attributes(params[:store])
        format.html { redirect_to @store, notice: 'Store was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    @store = Store.find(params[:id])
    @store.destroy

    respond_to do |format|
      format.html { redirect_to stores_path }
      format.json { head :no_content }
    end
  end
end
