class CreateRoles < ActiveRecord::Migration
  def change
    create_table(:roles) do |t|
      t.column :title, :string
      t.timestamps
    end
  end
end
