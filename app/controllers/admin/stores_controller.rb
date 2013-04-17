class Admin::StoresController < ApplicationController
  load_and_authorize_resource
  before_filter :store, except: [:index]

  def index
    @stores = Store.order("name")
  end

  def activate
    authorize! :manage, Store
    if store.approve_status
      UserMailer.delay.store_approval_confirmation(@store.users.first, @store)
      redirect_to admin_stores_path, notice: "#{@store.name} has been approved."
    else
      flash[:errors] = "We're sorry. There was a problem approving #{store.name}."
      redirect_to admin_stores_path
    end
  end

  def create_admin
    new_admin = User.find_by_email(params[:email])
    store.add_admin(new_admin)
    redirect_to admin_stores_path(params[:store_id])
  end

  def decline
    authorize! :manage, Store
    @store = Store.find(params[:store_id])
    user = @store.users.first
    if @store.decline_status
      redirect_to admin_stores_path, notice: "The status for #{@store.name} has been set to 'declined' and a message has been sent to #{user.email}."
      UserMailer.delay.store_decline_notification(user.email, @store.name)
    else
      flash[:errors] = "We're sorry. There was a problem declining #{store.name}."
      redirect_to admin_stores_path
    end
  end

  def disable
    authorize! :manage, Store
    if store.disable_status
      redirect_to admin_stores_path, notice: "#{store.name} has been disabled."
    else
      flash[:errors] = "We're sorry. There was a problem disabling #{store.name}."
      redirect_to admin_stores_path
    end
  end

  def enable
    authorize! :manage, Store
    if store.enable_status
      redirect_to admin_stores_path, notice: "#{store.name} has been enabled."
    else
      flash[:errors] = "We're sorry. There was a problem disabling #{store.name}."
      redirect_to admin_stores_path
    end
  end

private
  def store
    @store ||= Store.find(params[:store_id])
  end
end
