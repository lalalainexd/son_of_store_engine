class SearchController < ApplicationController
  def user_search
    @products = product_search(params[:search])
    @user = current_user
    @orders = user_orders_search(params[:search], current_user)
    render :user_search
  end

  def admin_search
    @orders = Order.all
    render :admin_search
  end

  def admin_advanced_search
    @params = params
    @orders = admin_advanced_orders_search(params)
    render :admin_search
  end

private

  def admin_advanced_orders_search(search)
    orders = Order.all
    orders = keyword_search(search, orders)    
    
    orders = price_search(search, orders)
    orders = date_search(search, orders)
    orders = email_search(search, orders)
  end

  def date_search(search, orders)
    searched_date = Date.parse(search[:date][:year]+"-"+search[:date][:month]+"-"+search[:date][:day])


    if search[:date_drop] != ""
      if search[:date_drop] == "Before Date"
        orders = orders.where(:created_at < searched_date)
      elsif search[:date_drop] == "After Date"

      elsif search[:date_search] == "On Date"
        orders = orders.where(created_at: searched_date)
      end
    end
    orders
  end

  def price_search(search, orders)
    if search[:price] != ""
      if search[:price_drop] == "More Than"

      elsif search[:price_drop] == "Less Than"

      elsif search[:price_drop] == "Equal"
        orders = orders.where(total_cost: search[:price].to_i)
      end
    end
    orders
  end

  def email_search(search, orders)
    if search[:email] != ""
      new_orders = Order.where(:user_id => "none")
      orders.each do |order|
        user = user_from_order_id(order.id)
        if search[:email] == user.email
          new_orders << order
        end
      end
      orders = new_orders
    end
    orders
  end

  def keyword_search(search, orders)
    if search[:advanced_search] != ""
      not_orders = Order.where(:user_id => "none")
      orders = line_item_finder(not_orders, orders, search[:advanced_search])
    end
    orders
  end

  def user_from_order_id(order_id)
    order = Order.where(id: order_id.to_i).first
    user = User.where(id: order.user_id.to_i).first
  end

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

  def user_orders_search(search, user)
    if user
      orders = Order.where(:user_id => user.id)
    else 
      orders = Order.where(:user_id => "none")
    end

    returned_orders = Order.where(:user_id => "none")

    if search && user
      returned_orders += orders.find(:all, :conditions => ['status LIKE ?', 
                                            "%#{search}%"])
      returned_orders = line_item_finder(returned_orders, orders, search)
    else
      returned_orders = orders
    end

    returned_orders.uniq
  end

  def line_item_finder(returned_orders, orders, search)
    orders.each do |order|
      order.line_items.each do |line_item|
        if line_item.product.name.downcase.include? search.downcase
          returned_orders << order
        end
        if line_item.product.description.downcase.include? search.downcase
          returned_orders << order
        end
      end
    end
    returned_orders
  end
end
