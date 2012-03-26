class Agendaitemtype < ActiveRecord::Base
  has_many :agendaitems
  has_many :agendaitemtype_eventtypes
  has_many :eventtypes, :through => :agendaitemtype_eventtypes
end
