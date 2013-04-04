class SearchController < ApplicationController
  def user_search
    @products = product_search(params[:search])
    @user = current_user
    @orders = user_orders_search(params[:search], current_user)
    render :user_search
  end

private

  def product_search(search)
    if search
      products = Product.find(:all,
        :conditions => ['name ILIKE ?', "%#{search}%"])
      products += Product.find(:all,
        :conditions => ['description ILIKE ?', "%#{search}%"])
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
