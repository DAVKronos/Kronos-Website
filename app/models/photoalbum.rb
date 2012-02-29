class Photoalbum < ActiveRecord::Base
  belongs_to :agendaitem
  has_many :photos
  
  accepts_nested_attributes_for :photos
  validates_associated :photos
end
