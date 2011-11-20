class Event < ActiveRecord::Base
  belongs_to :eventtype
  belongs_to :agendaitem
  has_many :results, :dependent => :delete_all
  accepts_nested_attributes_for :results, :allow_destroy => true, :reject_if => proc { |attributes| attributes["result"].blank? }
end
