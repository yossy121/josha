class Category < ActiveRecord::Base
  # 従属関係
  has_many :companies

  enum 
end
