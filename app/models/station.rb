class Station < ActiveRecord::Base
  # 従属関係
  has_many :user_station_statuses
  belongs_to :state
  belongs_to :company

  scope :company_is, -> (company_id) { where("stations.company_id = ? and stations.delete_flag = ?", company_id, 0) }
  scope :not_abolish, -> { where("stations.abolished_flag = ?", 0) }
  scope :station_user_is, -> (user_id) { where("user_station_statuses.user_id = ?", user_id) }
  scope :visit_true, -> { where("user_station_statuses.visit_chk = ? and user_station_statuses.delete_flag = ?", 1, 0) }

  enum abolished_flag: {not_abolished: 0, abolished: 1}
  enum delete_flag: {not_delete: 0, deleted: 1}
end
