# == Schema Information
#
# Table name: mailinglists
#
#  id          :integer          not null, primary key
#  name        :text
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  local_part  :string(255)
#

class Mailinglist < ActiveRecord::Base
  has_many :mailinglist_memberships

  attr_accessible :description, :name, :local_part

  validates :name, :presence => true
  validates :local_part, :presence => true, :format => {:with => /\A(\w)*\z/}


end
