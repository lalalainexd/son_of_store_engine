class SearchController < ApplicationController
  def user_search
    @products = product_search(params[:search]) 
    @user = current_user
    @stuff = []
    @orders = user_order_search(params[:search], current_user)
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

  def user_order_search(search, user)
    if user
      orders = Order.where(:user_id => user.id)
    else 
      orders = Order.where(:user_id => "none")
    end

    returned_orders = Order.where(:user_id => "none")

    if search && user
      returned_orders += orders.find(:all, :conditions => ['status LIKE ?', 
                                            "%#{search}%"])
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
    else
      returned_orders = orders
    end

    returned_orders
  end
end

#orders = orders.where(:user_id => user.id)
# order_ids = []
# order.each do |order|
#   order_ids << order.id
# end
# LineItem.find(:all, :conditions => ['name LIKE ?', "%#{search}%"])

# products = Product.order(:name)
# products = products.where("name like ?", "%#{keywords}%") if keywords.present?
# products = products.where(category_id: category_id) if category_id.present?
# products = products.where("price >= ?", min_price) if min_price.present?
# products = products.where("price <= ?", max_price) if max_price.present?
# products









