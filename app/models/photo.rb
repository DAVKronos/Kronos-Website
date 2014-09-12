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

class Photo < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  has_attached_file :photo, :styles => { :thumb => "260x180#", :normal => "1680x1050>"}, :path => ":rails_root/public/system/:attachment/:hash.:extension",
  :url => "/system/:attachment/:hash.:extension", :hash_secret => "longSecretString"
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
  
  
  
    # How to implement on Heroku with processing in the background
    # http://madeofcode.com/posts/42-paperclip-s3-delayed-job-in-rails

    # cancel post-processing now, and set flag...
       before_photo_post_process do |image|
         if !image.processing && image.photo_changed?
           image.processing = true
           false # halts processing
         end
       end

       # call method from after_save that will be processed in the background
       after_save do |image| 
         if image.processing
           processImageJob(image)
         end
       end

       def processImageJob(image)
           image.regenerate_styles!
       end
       handle_asynchronously :processImageJob

       # generate styles
       def regenerate_styles!
         self.photo.reprocess! 
         self.processing = false
         self.save(:validations => false)
       end

       # detect if our source file has changed
       def photo_changed?
         self.photo_file_size_changed? || 
         self.photo_file_name_changed? ||
         self.photo_content_type_changed?
       end
end
