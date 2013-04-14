class AddRoleIdToUserStores < ActiveRecord::Migration
  def change
    add_column :user_stores, :role_id, :integer
  end
end
