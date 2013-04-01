class AddTotalCostToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :total_cost, :integer
  end
end
