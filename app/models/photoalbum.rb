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

class Photoalbum < ActiveRecord::Base
  belongs_to :agendaitem

  attr_accessible :name, :agendaitem_id
  attr_accessible :name, :agendaitem_id, :public, :as => :admin

  has_many :photos, :dependent => :destroy
  accepts_nested_attributes_for :photos
  validates_associated :photos
end

