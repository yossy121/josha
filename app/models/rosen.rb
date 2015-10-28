class Rosen < ActiveRecord::Base
  # 従属関係
  has_many :sections
  has_many :user_rosen_statuses
  belongs_to :company
  belongs_to :start_station, class_name: "Station", foreign_key: "start_id"
  belongs_to :end_station, class_name: "Station", foreign_key: "end_id"

  scope :company_is, -> (company_id) { where("rosens.company_id = ? and rosens.delete_flag = ?", company_id, 0) }
  scope :rosen_is, -> (rosen_id) { where(["sections.rosen_id = ? and sections.delete_flag = ?", rosen_id, 0]) }
  scope :rosen_user_is, -> (user_id) { where("user_rosen_statuses.user_id = ?", user_id) }
  scope :section_user_is, -> (user_id) { where("user_section_statuses.user_id = ?", user_id) }
  
  enum abolished_flag: {not_abolished: 0, abolished: 1}
  enum delete_flag: {not_delete: 0, deleted: 1}
end
