class AddImageNameToProduct < ActiveRecord::Migration
  def change
    add_column :products, :image_name, :string, :default => "98"
  end
end
