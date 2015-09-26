class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :category_id
      t.integer :abolished_flag
      t.integer :delete_flag
      t.integer :company_sub_id

      t.timestamps null: false
    end
  end
end
