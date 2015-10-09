class CreateUserStationStatuses < ActiveRecord::Migration
  def change
    create_table :user_station_statuses do |t|
      t.integer :user_id
      t.integer :station_id
      t.date :visit_day
      t.integer :visit_chk
      t.integer :delete_flag

      t.timestamps null: false
    end
  end
end
