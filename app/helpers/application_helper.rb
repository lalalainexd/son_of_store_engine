module ApplicationHelper
  def cart_cost
    cart = current_cart
    subtotals = cart.line_items.map do |item|
      item.total
    end
    amount_in_dollars(add_all(subtotals))
  end

  def amount_in_dollars(cents)
    number_to_currency(cents.to_f / 100)
  end

  def add_all(items=[])
    items.inject(0, :+)
  end

  def category_counts()
    ########Implement this
  end
end
