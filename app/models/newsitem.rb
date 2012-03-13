class Newsitem < ActiveRecord::Base
  belongs_to :user
  has_many :reactions
end
# == Schema Information
#
# Table name: newsitems
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  news       :text
#  agreed     :boolean
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  user_id    :integer
#  agreed_by  :integer
#

