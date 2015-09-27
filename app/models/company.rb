class Company < ActiveRecord::Base
  # 従属関係
  has_many :rosens
  has_many :stations
  belongs_to :category

  enum abolished_flag: {not_abolished: 0, abolished: 1}
  enum delete_flag: {not_delete: 0, deleted: 1}
end
