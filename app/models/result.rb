class Result < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  has_many :reactions, :dependent => :destroy
  attr_accessor :calculated
  
  def calculatedResult
    result = self[:result].gsub(/,/, ".")
    if self.event.eventtype.measuringunit =~ /sec/
      tempResult = ChronicDuration.parse(result)   # parse the human input
    else
      tempResult = result
    end
    calculation = event.eventtype.calculate_result(tempResult, self.event.distance)
    if self.event.eventtype.calculated_unit =~ /punt/
      calculation.to_i
    else
      calculation
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

