require 'numbers_in_words'
require 'numbers_in_words/duck_punch'
require 'dentaku'

class MagicNumber
  COUNT_LITERALLY = false
    
  def initialize(number)
    @number = @original_number = number
    clean_slate!
  end
  
  def clean_slate!
    @answers = []
    @number  = numberize(@original_number)
  end
  
  def answer_in_words
    result = answer.map {|step| "#{step.first} is #{step.last}" }
    result << "And four is the Magic Number."
    result
  end
  
  def answer
    calculate_answer(@number)
    while it = calculate_answer(@answers[-1].last)
      break if it == 4
    end
    result = @answers
    clean_slate!
    result
  end
  
  def calculate_answer(n)
    return false unless n
    result = length_of_words(n)
    @answers << [n, result] unless n == 4
    result
  end
  
  def length_of_words(n)
    if COUNT_LITERALLY
      n.in_words.gsub("minus","negative").gsub("and ","").length
    else
      n.in_words.gsub("minus","negative").gsub("and","").gsub("-", "").gsub(" ", "").length
    end
  end
  
  def numberize(n)
    n = n.to_s.downcase
    case
    when n.include?('+'), n.include?('/'), n.include?('-'), n.include?('*')
      Dentaku::Calculator.new.evaluate(n)
    when n.in_numbers != 0
      n.gsub(/^negative/,'minus').in_numbers
    when n == 'infinity'
      infinity = 'infinity'.length
      @answers << ['Infinity', infinity]
      infinity
    when n == 'pi'
      pi = 'pi'.length
      @answers << ['Pi', pi]
      pi
    when n.include?(".")
      n.to_f
    else
      n.to_i
    end
  end
  
end