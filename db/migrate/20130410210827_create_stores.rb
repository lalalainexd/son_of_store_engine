class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :slug
      t.text :description

      t.timestamps
    end
  end
end
