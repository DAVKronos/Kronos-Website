# == Schema Information
#
# Table name: folders
#
#

class Folder < ApplicationRecord
  has_many :folders, -> { order("name") }, :dependent => :destroy
  has_many :kronometers
end
