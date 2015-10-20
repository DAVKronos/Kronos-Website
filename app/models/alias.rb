class Alias < ActiveRecord::Base
  attr_accessible :name, :emailaddress, :description

#  has_and_belongs_to_many :mailinglists
end

