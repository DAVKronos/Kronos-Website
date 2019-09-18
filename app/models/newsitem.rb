# == Schema Information
#
# Table name: newsitems
#
#  id                        :integer          not null, primary key
#  title                     :string(255)
#  news                      :text
#  agreed                    :boolean
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  user_id                   :integer
#  agreed_by                 :integer
#  articlephoto_file_name    :string(255)
#  articlephoto_content_type :string(255)
#  articlephoto_file_size    :integer
#  articlephoto_updated_at   :datetime
#

class Newsitem < ApplicationRecord
  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_attached_file :articlephoto, :styles => { :normal => "x150>" , :slider => "480x260#", :carrousel => "750x260#"}, :path => ":rails_root/public/system/:attachment/:hash.:extension",
  :url => "/system/:attachment/:hash.:extension", :hash_secret => "ci74eFweHJz1SuFRxcWK5gOQvZMrbHhThljgLz1JeCHVnYi9M8w29TBxuf696mE"
  validates_attachment_content_type :articlephoto, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  
end
