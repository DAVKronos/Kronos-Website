class Newsitem < ActiveRecord::Base
  belongs_to :user
  has_many :reactions
  has_attached_file :articlephoto, :styles => { :normal => "x150>"}, :path => ":rails_root/public/system/:attachment/:hash.:extension",
  :url => "/system/:attachment/:hash.:extension", :hash_secret => "ci74eFweHJz1SuFRxcWK5gOQvZMrbHhThljgLz1JeCHVnYi9M8w29TBxuf696mE"
  
  
end
# == Schema Information
#
# Table name: newsitems
#
#  id                        :integer         not null, primary key
#  title                     :string(255)
#  news                      :text
#  agreed                    :boolean
#  created_at                :datetime
#  updated_at                :datetime
#  user_id                   :integer
#  agreed_by                 :integer
#  articlephoto_file_name    :string(255)
#  articlephoto_content_type :string(255)
#  articlephoto_file_size    :integer
#  articlephoto_updated_at   :date
#

