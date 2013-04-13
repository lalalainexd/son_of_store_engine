class Admin::StoresController < ApplicationController
  load_and_authorize_resource

  def index
    @stores = Store.where(Store.arel_table[:status].not_eq("declined"))
  end

  def activate
    @store = Store.find(params[:store_id])
    if @store.approve_status
      UserMailer.store_approval_confirmation(@store.users.first, @store).deliver
      redirect_to admin_stores_path, notice: "#{@store.name} has been approved."
    else
      flash[:errors] = "We're sorry. There was a problem approving #{@store.name}."
      redirect_to admin_stores_path
    end
  end

  def decline
    @store = Store.find(params[:store_id])
    if @store.decline_status
      redirect_to admin_stores_path, notice: "The status for #{@store.name} has been set to 'declined'."
      UserMailer.store_decline_notification(@store.users.first, @store).deliver
    else
      flash[:errors] = "We're sorry. There was a problem declining #{@store.name}."
      redirect_to admin_stores_path
    end
  end

end
