require 'sinatra'
require 'sinatra/reloader'

@@secret_number = rand(100) + 1

@@number_of_guesses = 5

def generate_message(guess)
  unless guess.nil? || guess.empty?
    guess = guess.to_i
    if guess > @@secret_number
      @@number_of_guesses -= 1
      if guess - @@secret_number > 5
        message = "Way too high! " + number_of_guesses_message
      else
        message = "Too high! " + number_of_guesses_message
      end
      return message
    elsif guess < @@secret_number
      @@number_of_guesses -= 1
      if @@secret_number - guess > 5
        message = "Way too low! " + number_of_guesses_message
      else
        message = "Too low! " + number_of_guesses_message
      end
      return message
    elsif guessed?(guess)
      message = "You got it right! The SECRET NUMBER is #{@@secret_number}. "
      @@secret_number = rand(100) + 1
      @@number_of_guesses = 5
      message += "\nNew number has been genereted. " + number_of_guesses_message
      return message
    end

    if @@number_of_guesses == 0
      message = "You ran out of guesses. The secret number was #{@@secret_number}. "
      @@secret_number = rand(100) + 1

      @@number_of_guesses = 5
      message += "\nNew number has been generated. " + number_of_guesses_message
      message
    end
  else
    number_of_guesses_message
  end
end

def guessed?(guess)
  guess == @@secret_number
end

def number_of_guesses_message
  "Number of guesses left: #{@@number_of_guesses}"
end

get '/' do
  guess = params['guess']
  message = generate_message(guess)
  erb :index, :locals => { :message => message }
end
