class CreateUserSectionStatuses < ActiveRecord::Migration
  def change
    create_table :user_section_statuses do |t|
      t.integer :user_id
      t.integer :section_id
      t.date :ride_day
      t.integer :ride_chk
      t.integer :delete_flag

      t.timestamps null: false
    end
  end
end
