class CreateUserStores < ActiveRecord::Migration
  def change
    create_table :user_stores do |t|
      t.references :user
      t.references :store

      t.timestamps
    end
    add_index :user_stores, :user_id
    add_index :user_stores, :store_id
  end
end
