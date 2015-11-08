class Section < ActiveRecord::Base
  # 従属関係
  has_many :user_section_statuses
  belongs_to :rosen
  delegate :company, to: :rosen
  belongs_to :start_station, class_name: "Station", foreign_key: "start_id"
  belongs_to :end_station, class_name: "Station", foreign_key: "end_id"

  scope :rosen_is, -> (rosen_id) { where(["sections.rosen_id = ? and sections.delete_flag = ?", rosen_id, 0]) }
  scope :section_user_is, -> (user_id) { where("user_section_statuses.user_id = ?", user_id) }
  scope :ride_true, -> { where("user_section_statuses.ride_chk = ? and user_section_statuses.delete_flag = ?", 1, 0) }
#  scope :state_is, -> (state_id) { where("start_stations_sections.state_id = ? or end_stations_sections.state_id = ?", state_id, state_id)}
  scope :state_is, -> (state_id) { where("stations.state_id = ? or end_stations_sections.state_id = ?", state_id, state_id)}

  enum abolished_flag: {not_abolished: 0, abolished: 1}
  enum delete_flag: {not_delete: 0, deleted: 1}
end
