# == Schema Information
#
# Table name: photoalbums
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  agendaitem_id :integer
#

class Photoalbum < ApplicationRecord
  belongs_to :agendaitem

  has_many :photos, :dependent => :destroy
  accepts_nested_attributes_for :photos
  validates_associated :photos
  validates :name, :presence => true
  validates :name_en, :presence => true
  before_save :add_event_date

  def add_event_date
    if self.eventdate.nil? and self.agendaitem
        self.eventdate = self.agendaitem.date
    end
  end
end

