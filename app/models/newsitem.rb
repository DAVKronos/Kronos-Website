class Newsitem < ActiveRecord::Base
  belongs_to :user
  has_many :reactions
end
