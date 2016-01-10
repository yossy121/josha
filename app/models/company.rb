class Company < ActiveRecord::Base
  # 従属関係
  has_many :rosens
  has_many :sections, through: :rosens
  has_many :stations
  belongs_to :category

  scope :category_is, -> (category_id) { where("companies.category_id = ? and companies.delete_flag = ?", category_id, 0) }
  scope :not_delete, -> { where("companies.delete_flag = ?", 0) }

  enum abolished_flag: {not_abolished: 0, abolished: 1}
  enum delete_flag: {not_delete: 0, deleted: 1}
end
