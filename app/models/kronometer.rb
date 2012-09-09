# == Schema Information
#
# Table name: kronometers
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  date              :date
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Kronometer < ActiveRecord::Base
  attr_accessible :date, :file, :name
  
  has_attached_file :file, :styles => { :thumb => ["260", :png] }
end
