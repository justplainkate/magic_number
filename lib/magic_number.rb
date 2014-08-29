require 'numbers_in_words'
require 'numbers_in_words/duck_punch'

def ask_for_number
  puts "Give me a number and I'll tell you how Four is the Magic Number."
  response = gets.chomp.downcase
  
  case
  when response.in_numbers != 0
   response.gsub(/^negative/,'minus').in_numbers
  when response == 'infinity'
   infinity = 'infinity'.length
   puts "Infinity is #{infinity}"
   infinity
  when response == 'pi'
   pi = 'pi'.length
   puts "Pi is #{pi}"
   pi
  when response.include?(".")
    response.to_f
  else
   response.to_i
  end
end

def calculate_answer(number)
  return false unless number
  result = length_of_words(number)
  puts "#{number} is #{result}" unless number == 4
  result
end

def length_of_words(n)
  count_literally = false
  if count_literally == true
    n.in_words.gsub("minus","negative").gsub("and ","").length
  else
    n.in_words.gsub("minus","negative").gsub("and","").gsub("-", "").gsub(" ", "").length
  end
end

def play
  answer = calculate_answer(ask_for_number)
  while answer = calculate_answer(answer)
    if answer == 4
      answer = false
      puts "And four is the Magic Number."
    end
  end
end


