class UserStationStatus < ActiveRecord::Base
  # 従属関係
  belongs_to :user
  belongs_to :station

  enum delete_flag: {not_delete: 0, deleted: 1}

  scope :not_delete, -> { where("delete_flag = ?", 0) }
  scope :user_is, -> (user_id) { where("user_id = ?", user_id) }
  scope :station_is, -> (station_id) { where("station_id = ?", station_id) }

end
