class UserSectionStatus < ActiveRecord::Base
  # 従属関係
  belongs_to :user
  belongs_to :section

  enum delete_flag: {not_delete: 0, deleted: 1}
end
