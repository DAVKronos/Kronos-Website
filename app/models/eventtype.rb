# == Schema Information
#
# Table name: eventtypes
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  formula         :string(255)
#  shortname       :string(255)
#  measuringunit   :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  calculated_unit :string(255)
#  show_wind       :boolean          default(FALSE)
#  female_formula  :string(255)
#

class Eventtype < ActiveRecord::Base
  has_many :events, :dependent => :destroy
  has_many :agendaitemtype_eventtypes
  has_many :agendaitemtypes, :through => :agendaitemtype_eventtypes
  has_many :results, :through => :events
  
  accepts_nested_attributes_for :agendaitemtype_eventtypes, :allow_destroy => true

  def calculate_result(result, distance, gender)
    engine = MathEngine::MathEngine.new
	formula = self.formula
	if gender != "Man" && self.female_formula
		formula = self.female_formula
	end
    formula = formula.gsub(/\$distance/, distance.to_s ) if (distance and formula)
    engine.evaluate(formula.gsub(/\$result/, result.to_s)) if (formula)              # Evaluate the expression and output the result
    
    rescue MathEngine::MathEngine::ParseError
      0

  end
end
