class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.integer :section_sub_id
      t.integer :start_id
      t.integer :end_id
      t.integer :next_hop_id
      t.integer :rosen_id
      t.decimal :kilo
      t.integer :abolished_flag
      t.integer :delete_flag

      t.timestamps null: false
    end
  end
end
