class Admin::StoresController < ApplicationController
  load_and_authorize_resource

  def index
    @stores = Store.order("name")
  end

  def activate
    authorize! :manage, Store
    @store = Store.find(params[:store_id])
    if @store.approve_status
      UserMailer.delay.store_approval_confirmation(@store.users.first, @store)
      redirect_to admin_stores_path, notice: "#{@store.name} has been approved."
    else
      flash[:errors] = "We're sorry. There was a problem approving #{@store.name}."
      redirect_to admin_stores_path
    end
  end

  def decline
    authorize! :manage, Store
    @store = Store.find(params[:store_id])
    user = @store.users.first
    if @store.decline_status
      UserMailer.store_decline_notification(user, @store).deliver
      redirect_to admin_stores_path, notice: "The status for #{@store.name} has been set to 'declined'."
    else
      flash[:errors] = "We're sorry. There was a problem declining #{@store.name}."
      redirect_to admin_stores_path
    end
  end

  def disable
    authorize! :manage, Store
    @store = Store.find(params[:store_id])
    if @store.disable_status
      redirect_to admin_stores_path, notice: "#{@store.name} has been disabled."
    else
      flash[:errors] = "We're sorry. There was a problem disabling #{@store.name}."
      redirect_to admin_stores_path
    end
  end

  def enable
    authorize! :manage, Store
    @store = Store.find(params[:store_id])
    if @store.enable_status
      redirect_to admin_stores_path, notice: "#{@store.name} has been enabled."
    else
      flash[:errors] = "We're sorry. There was a problem disabling #{@store.name}."
      redirect_to admin_stores_path
    end
  end

end
