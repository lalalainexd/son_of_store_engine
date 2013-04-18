module ApplicationHelper
  def cart_cost
    cart = current_cart
    if cart.nil?
      amount_in_dollars(0)
    else
      subtotals = cart.line_items.map do |item|
        item.total
      end
      amount_in_dollars(add_all(subtotals))
    end
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
