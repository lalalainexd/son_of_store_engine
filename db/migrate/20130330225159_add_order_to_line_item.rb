class AddOrderToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :order_id, :integer
    add_column :line_items, :price, :integer
  end
end
