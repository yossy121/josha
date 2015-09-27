class State < ActiveRecord::Base
  # 従属関係
  has_many :stations

  enum delete_flag: {not_delete: 0, deleted: 1}
end
