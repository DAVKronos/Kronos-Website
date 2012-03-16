class Eventtype < ActiveRecord::Base
  has_many :events
  
  def stringcal(expressie)
    while expressie.scan(/\([^\(\)]+\)/).size > 0
      ex = expressie[/\([^\(\)]+\)/]
      expressie.sub!(/\([^\(\)]+\)/, cal(ex).to_s)
    end
    return expressie
  end

  def cal(exp)
    tempstr = exp
    gescand = tempstr.scan(/(\d+\.?\d*)/)
    actie = tempstr.scan(/(\*|\+|\-|\/|\^|\%)/)[0][0]
    operand1 = gescand[0][0].to_f
    operand2 = gescand[1][0].to_f

    case actie
      when "+"
        result = operand1 + operand2
      when "-"
        result = operand1 - operand2
      when "*"
        result = operand1 * operand2
      when "/"
        result = operand1 / operand2
      when "^"
        result = operand1 ** operand2
      when "%"
        result = operand1 % operand2
      else
        raise RecordNotFound
    end
    return result
  end
  
  
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

