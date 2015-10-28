class CreateUserRosenStatuses < ActiveRecord::Migration
  def change
    create_table :user_rosen_statuses do |t|
      t.integer :user_id
      t.integer :rosen_id
      t.decimal :ride_kilo_sum
      t.decimal :ride_abo_kilo_sum
      t.integer :delete_flag

      t.timestamps null: false
    end
  end
end
