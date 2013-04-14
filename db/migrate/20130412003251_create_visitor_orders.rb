class CreateVisitorOrders < ActiveRecord::Migration
  def change
    create_table(:visitor_orders) do |t|
      t.integer :order_id, null: false
      t.integer :visitor_id, null: false
    end
  end

end
