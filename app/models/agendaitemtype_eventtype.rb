# == Schema Information
#
# Table name: agendaitemtype_eventtypes
#
#  id                :integer          not null, primary key
#  agendaitemtype_id :integer
#  eventtype_id      :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class AgendaitemtypeEventtype < ApplicationRecord
  belongs_to :agendaitemtype
  belongs_to :eventtype
  
  validates :agendaitemtype_id, :presence => true
  validates :eventtype_id, :presence => true
end
