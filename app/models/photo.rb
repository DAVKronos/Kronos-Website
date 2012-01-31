class Photo < ActiveRecord::Base
  has_attached_file :photo, :styles => { :thumb => "100x100>" }
  belongs_to :photoalbum
  has_many :tags
end
