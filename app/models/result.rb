# == Schema Information
#
# Table name: results
#
#  id         :integer          not null, primary key
#  username   :string(255)
#  result     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :integer
#  user_id    :integer
#  wind       :decimal(, )
#  place      :integer
#

class Result < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy
  
  validates_presence_of :result
  
  def calculatedResult
    if self.calculated
      return self.calculated
	end
    if self[:result]
      result = self[:result].gsub(/,/, ".")
      if self.event.eventtype.measuringunit =~ /sec/
        tempResult = ChronicDuration.parse(result)   # parse the human input
      else
        tempResult = result
      end
	  if self.user
	    gender = self.user.sex
	  end
      calculation = event.eventtype.calculate_result(tempResult, self.event.distance, gender)
      if self.event.eventtype.calculated_unit =~ /punt/
        if calculation < 0 
          calculation = 0;
        end
        calculation = calculation.to_i
      end
	  self.calculated = calculation
	  self.save
	  return calculation
    end
  end
  
  def username=(val)
    user = User.find_by_name(val)
    self[:user_id] = user.id if user
    self[:username] = val
  end
  
  
end
