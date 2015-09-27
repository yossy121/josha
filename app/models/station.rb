class Station < ActiveRecord::Base
  # 従属関係
  belongs_to :state
  belongs_to :company

  enum abolished_flag: {not_abolished: 0, abolished: 1}
  enum delete_flag: {not_delete: 0, deleted: 1}
end
