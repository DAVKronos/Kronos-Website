# == Schema Information
#
# Table name: mailinglists
#
#  id          :integer          not null, primary key
#  name        :text
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Mailinglist < ActiveRecord::Base
  has_many :mailinglist_memberships

  attr_accessible :description, :name


end
