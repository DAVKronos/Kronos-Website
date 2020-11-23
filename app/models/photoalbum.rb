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

  def get_url_name
    if self.url
      if self.url.length > 40
        return self.url[0..37] + "..."
      else
        return self.url
      end
    else
      return ""
    end
  end

  def get_url
    if self.url
      if self.url.index("/") == 0
        return self.url
      elsif self.url["http://"]
        return self.url
      elsif self.url["https://"]
        return self.url
      else
        return "http://" + self.url
      end
    else
      return "#"
    end
  end
end

