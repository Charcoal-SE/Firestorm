class Flag < ActiveRecord::Base
  belongs_to :user
  has_many :flag_data
  has_many :flag_comments
end
