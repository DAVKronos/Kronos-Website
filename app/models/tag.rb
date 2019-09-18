# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  photo_id   :integer
#  user_id    :integer
#  xpos       :integer
#  ypos       :integer
#  width      :integer
#  heigth     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ApplicationRecord
  belongs_to :photo
  belongs_to :user
end
