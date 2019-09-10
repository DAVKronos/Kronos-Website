# == Schema Information
#
# Table name: user_types
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  donor       :boolean
#  competition :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class UserType < ActiveRecord::Base
  has_many :users
end
