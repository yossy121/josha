class Category < ActiveRecord::Base
  # 従属関係
  has_many :companies

  enum delete_flag: {not_delete: 0, deleted: 1}
end
