class Event < ActiveRecord::Base
  belongs_to :eventtype
  belongs_to :agendaitem
  has_many :results, :dependent => :delete_all
  accepts_nested_attributes_for :results, :allow_destroy => true, :reject_if => proc { |attributes| attributes["result"].blank? }
end
# == Schema Information
#
# Table name: events
#
#  id            :integer         not null, primary key
#  date          :time
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  eventtype_id  :integer
#  agendaitem_id :integer
#  distance      :float
#

