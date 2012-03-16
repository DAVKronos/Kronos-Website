class Result < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  has_many :reactions
  attr_accessor :calculated
  
  def result=(val)
        if self.event.event_type.measuringunit == "s"
          self[:best_performance] = ChronicDuration.parse(val)   # parse the human input
        else
          self[:best_performance] = val
        end
  end
  
  
end
# == Schema Information
#
# Table name: results
#
#  id         :integer         not null, primary key
#  username   :string(255)
#  result     :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  event_id   :integer
#  user_id    :integer
#

