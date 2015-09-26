class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :mail
      t.integer :delete_flag

      t.timestamps null: false
    end
  end
end
