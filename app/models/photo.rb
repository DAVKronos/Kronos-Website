class Photo < ActiveRecord::Base
  has_attached_file :photo, :styles => { :thumb => "260x180#", :normal => "940>"}
  belongs_to :photoalbum
  has_many :tags, :reactions
  
  validates_attachment_presence :photo
  
  
  
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

       # generate styles (downloads original first)
       def regenerate_styles!
         self.photo.reprocess! 
         self.processing = false   
         self.save(:validations => false)
       end

       # detect if our source file has changed
       def photo_changed?
         self.photo_file_size_changed? || 
         self.photo_file_name_changed? ||
         self.photo_content_type_changed? || 
         self.photo_updated_at_changed?
       end
end
