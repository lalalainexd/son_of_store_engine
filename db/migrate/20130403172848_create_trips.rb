class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :children
      t.integer :adults
      t.string :city_of_origin
      t.string :pace
      t.string :month_of_departure

      t.timestamps
    end
  end
end
