# == Schema Information
#
# Table name: apps_exceptions
#
#  id          :integer          not null, primary key
#  email       :string(255)
#  way         :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  group_email :string(255)
#

class AppsException < ActiveRecord::Base
  attr_accessible :email, :way
end
