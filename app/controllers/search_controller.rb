class SearchController < ApplicationController
  def user_search
    @products = product_search(params[:search]) 
    @user = current_user
    @orders = Order.all #order_search(params[:search], current_user)
    render :user_search
  end

  def admin_search
    @orders = Order.all
    render :admin_search
  end

private

  def product_search(search)
    if search
      products = Product.find(:all, 
        :conditions => ['name LIKE ?', "%#{search}%"])
      products += Product.find(:all, 
        :conditions => ['description LIKE ?', "%#{search}%"])
    else
      Product.find(:all)
    end
  end

  def order_search(search, user)
    if search && user
      # orders = Order.where(:user_id => user.id)
      # order_ids = []
      # order.each do |order|
      #   order_ids << order.id
      # end
      # LineItem.find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    end
  end
end
