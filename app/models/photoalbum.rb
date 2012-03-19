class Photoalbum < ActiveRecord::Base
  belongs_to :agendaitem
  has_many :photos, :dependent => :destroy
  accepts_nested_attributes_for :photos
  validates_associated :photos
  
  validates_uniqueness_of :agendaitem_id, :unless => self.agendaitem_id == nil
end
# == Schema Information
#
# Table name: photoalbums
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  agendaitem_id :integer
#

