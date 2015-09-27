class Rosen < ActiveRecord::Base
  # 従属関係
  has_many :sections
  belongs_to :company
  belongs_to :start_station, class_name: "Station", foreign_key: "start_id"
  belongs_to :end_station, class_name: "Station", foreign_key: "end_id"

  enum abolished_flag: {not_abolished: 0, abolished: 1}
  enum delete_flag: {not_delete: 0, deleted: 1}
end
