class Eventtype < ActiveRecord::Base
  has_many :events
  
  def calculate_result(result)
    engine = MathEngine::MathEngine.new   
    engine.evaluate(self.formula.gsub(/\$result/, result.to_s))              # Evaluate the expression and output the result

  end  
end
# == Schema Information
#
# Table name: eventtypes
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  formula         :string(255)
#  shortname       :string(255)
#  measuringunit   :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  calculated_unit :string(255)
#

