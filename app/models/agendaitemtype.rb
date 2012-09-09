# == Schema Information
#
# Table name: agendaitemtypes
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  is_match   :boolean
#

class Agendaitemtype < ActiveRecord::Base
  has_many :agendaitems
  has_many :agendaitemtype_eventtypes
  has_many :eventtypes, :through => :agendaitemtype_eventtypes
end
