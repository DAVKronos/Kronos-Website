class Result < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  has_many :reactions
  
  def stringcal(expressie)
    while expressie.scan(/\([^\(\)]+\)/).size > 0
      ex = expressie[/\([^\(\)]+\)/]
      expressie.gsub!(/\([^\(\)]+\)/, cal(ex).to_s)
    end
    return expressie
  end
  
  def timetoseconds(expressie)
    while expressie.scan(/(\d?\d?\:?\d?\d?\:\d?\d)/).size > 0
      gescand1 = expressie[/(\d?\d?\:?\d?\d?\:\d?\d)/]
      hours = gescand1.scan(/^(\d?\d)\:\d?\d\:\d?\d|^/)[0][0].to_i
      minutes = gescand1.scan(/(\d\d?)\:\d?\d\.?\d?\d?\d?$/)[0][0].to_i
      seconds = gescand1.scan(/(\d?\d)\.?\d?\d?\d?$/)[0][0].to_i
      expressie.gsub!(gescand1, (hours*3600 + minutes*60 + seconds).to_s)
    end
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
