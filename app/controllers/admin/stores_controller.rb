class Admin::StoresController < ApplicationController
  load_and_authorize_resource
  # GET /stores
  # GET /stores.json
  def index
    @stores = Store.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stores }
    end
  end

  def activate
    @store = Store.find(params[:store_id])
    if @store.approve_status
      redirect_to admin_stores_path, notice: "#{@store.name} has been approved."
      UserMailer.store_approval_confirmation(@store.users.first, @store).deliver
    else
      flash[:errors] = "We're sorry. There was a problem approving #{@store.name}."
      redirect_to admin_stores_path
    end
  end

  def decline
    @store = Store.find(params[:store_id])
    if @store.decline_status
      redirect_to admin_stores_path, notice: "The status for #{@store.name} has been set to 'declined'."
    else
      flash[:errors] = "We're sorry. There was a problem approving #{@store.name}."
      redirect_to admin_stores_path
    end
  end

  def show
    @store = Store.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @store }
    end
  end

  def new
    @store = Store.new
  end

  def edit
    @store = Store.find(params[:id])
  end

  def create
    #TODO add authorization
    @store = Store.new(params[:store])
    @store.users << current_user

    @store.user_stores.build
    @store.user_stores.first.user = current_user
    @store.user_stores.first.save

    if @store.save
      redirect_to @store, notice: 'Store was successfully created.'
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
