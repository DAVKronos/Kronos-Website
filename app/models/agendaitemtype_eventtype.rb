class AgendaitemtypeEventtype < ActiveRecord::Base
  belongs_to :agendaitemtype
  belongs_to :eventtype
end
