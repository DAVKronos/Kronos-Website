class AgendaitemtypeEventtype < ActiveRecord::Base
  belongs_to :agendaitemtype
  belongs_to :eventtype
  
  validates :agendaitemtype_id, :presence => true
  validates :eventtype_id, :presence => true
end
