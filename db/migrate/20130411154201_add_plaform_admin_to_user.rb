class AddPlaformAdminToUser < ActiveRecord::Migration
  def change
    add_column :users, :platform_administrator, :boolean, :default => false
  end
end
