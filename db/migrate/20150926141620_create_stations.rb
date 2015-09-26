class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :name
      t.string :name_ruby
      t.integer :company_id
      t.integer :state_id
      t.integer :abolished_flag
      t.integer :delete_flag

      t.timestamps null: false
    end
  end
end
