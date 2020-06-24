# -*- coding: binary -*-
module Msf
module Serializer

class OptConditions

 #Check a condition's result
  def self.condition_result(left_value, operator, right_value)
    result = false

    case operator
    when "=="
      result = left_value == right_value
    when "!="
      result = left_value != right_value
    when "in"
#      right_value = right_value.split(',')
      result = right_value.include?(left_value)
    when "nin"
      right_value = right_value.split(',')
      result = right_value.include?(left_value)
      result = !result
    else
      result = true
    end

    result

  end



  #Check an OPTION conditions. This function supports
  #self.dump_options()

  def self.opt_condition_checked(condition, mod, opt)
    result = false

    condition = condition.nil? ? "nil" : condition

    if ((condition != []) and (condition != "nil"))
      operator = condition[1]
      right_value = condition[2]
      print(operator)

      if condition[0][0..5] == "OPTION"
        left_name = condition[0][7..10]
        left_value = mod.datastore[left_name].nil? ? opt.default : mod.datastore[left_name]
        result = condition_result(left_value, operator, right_value)

      elsif condition != [] and condition[0] == "ACTION"
        left_value = mod.action.name.to_s
        result = condition_result(left_value, operator, right_value)

      elsif condition != [] and condition[0] == "TARGET"
        left_value = mod.target.name.to_s
        result = condition_result(left_value, operator, right_value)
      else
        result = true
      end

    else
      result = true
    end
    result
  end

end #end_class

end end #end_modules
