class Photo < ActiveRecord::Base
  has_attached_file :photo, :styles => { :thumb => "260x180#", :normal => "940x540" }
  belongs_to :photoalbum
  has_many :tags
end
