class Dashboard
  attr_reader :store, :admin

  def initialize(store, admin)
    @store = store
    @admin = admin

  end

  def products
    @products = store.products.active
  end

  def orders
    @order = Order.products.joins(:stores).where('products.store_id = ?', store.id)
  end

  def statuses
    %w[pending cancelled paid shipped returned]
  end

  def categories
    @categories ||= store.categories.by_name
  end

  def retired_products
    @retired_products ||= store.products.retired
  end

  def orders_by_status
    orders_with_status = {}
    Order.all.each do |order|
      if orders_with_status[order.status] == nil
        orders_with_status[order.status] = [order]
      else
        orders_with_status[order.status] << order
      end
    end
    orders_with_status
  end
end
