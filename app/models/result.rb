class Result < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  has_many :reactions
  attr_accessor :calculated
  
  def calculatedResult
    if self.event.eventtype.measuringunit == "s"
      tempResult = ChronicDuration.parse(self[:result])   # parse the human input
    else
      tempResult = self[:result]
    end
    self.event.eventtype.calculate_result(tempResult).to_i
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

