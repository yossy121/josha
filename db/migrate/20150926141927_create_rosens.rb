class CreateRosens < ActiveRecord::Migration
  def change
    create_table :rosens do |t|
      t.string :name
      t.integer :start_id
      t.integer :end_id
      t.decimal :kilo
      t.integer :company_id
      t.integer :abolished_flag
      t.integer :delete_flag
      t.integer :rosen_sub_id

      t.timestamps null: false
    end
  end
end
