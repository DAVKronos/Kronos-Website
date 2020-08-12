# == Schema Information
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  caption            :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  photoalbum_id      :integer
#  youtube_id         :string(255)
#  processing         :boolean
#  exif_date          :datetime
#

class Photo < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_attached_file :photo,
                    styles: {thumb: "260x180#", original: "1920x1080>"},
                    path: ":rails_root/public/system/:attachment/:hash.:extension",
                    url: "/system/:attachment/:hash.:extension",
                    hash_secret: "longSecretString",
                    convert_options: {thumb: "-quality 75 -strip", original: "-strip -quality 95"}
  validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  belongs_to :photoalbum
  has_many :tags, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  
  validates_attachment_presence :photo

  def to_jq_upload
      {
        "name" => self.photo_file_name,
        "size" => photo.size,
        "url" => photo.url,
        "thumbnail_url" => photo.url(:thumb),
        "delete_url" => photo_path(:id => id),
        "delete_type" => "DELETE" 
      }
    end
end
