class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.date :publishing_date
      t.string :title
      t.string :detail

      t.timestamps null: false
    end
  end
end
