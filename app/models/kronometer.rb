class Kronometer < ActiveRecord::Base
  attr_accessible :date, :file, :name
  
  has_attached_file :file, :styles => { :thumb => ["260", :png] }
end
