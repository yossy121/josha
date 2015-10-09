class UserStationStatus < ActiveRecord::Base
  # 従属関係
  belongs_to :user
  belongs_to :station

  enum delete_flag: {not_delete: 0, deleted: 1}
end
