class Category < ActiveRecord::Base
  # 従属関係
  has_many :companies

  scope :not_delete, -> { where("categories.delete_flag = ?", 0) }

  enum delete_flag: {not_delete: 0, deleted: 1}
end
