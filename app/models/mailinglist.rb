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

  has_many :users, :through => :mailinglist_memberships

  attr_accessible :description, :name, :local_part, :mailinglist_memberships_attributes

  accepts_nested_attributes_for :mailinglist_memberships, :allow_destroy => true

  validates :name, :presence => true
  validates :local_part, :presence => true, :format => {:with => /\A(\w)*\z/}


end
