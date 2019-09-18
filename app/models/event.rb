# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  date          :time
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  eventtype_id  :integer
#  agendaitem_id :integer
#  distance      :float
#

class Event < ApplicationRecord
  belongs_to :eventtype
  belongs_to :agendaitem
  has_many :results, :dependent => :destroy
  
  accepts_nested_attributes_for :results, :allow_destroy => true
end
