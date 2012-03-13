class Eventtype < ActiveRecord::Base
  has_many :events
end
# == Schema Information
#
# Table name: eventtypes
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  calculation     :string(255)
#  shortname       :string(255)
#  measuringunit   :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  calculated_unit :string(255)
#  display_type    :string(255)
#

