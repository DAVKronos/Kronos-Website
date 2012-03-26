class Eventtype < ActiveRecord::Base
  has_many :events, :dependent => :destroy
  has_many :agendaitemtype_eventtypes
  has_many :agendaitemtypes, :through => :agendaitemtype_eventtypes
  
  accepts_nested_attributes_for :agendaitemtype_eventtypes, :allow_destroy => true

  def calculate_result(result, distance)
    engine = MathEngine::MathEngine.new
    formula = self.formula
    formula = formula.gsub(/\$distance/, distance.to_s ) if distance
    engine.evaluate(formula.gsub(/\$result/, result.to_s))              # Evaluate the expression and output the result

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

