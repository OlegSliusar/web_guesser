require 'sinatra'

@@secret_number = rand(100) + 1
@@number_of_guesses = 5

helpers do
  def generate_message(guess, cheat)
    unless guess.nil? || guess.empty?
      guess = guess.to_i
      if guess > @@secret_number
        @@number_of_guesses -= 1
        if guess - @@secret_number > 5
          message = "Way too high! " + number_of_guesses_message
        else
          message = "Too high! " + number_of_guesses_message
        end
      elsif guess < @@secret_number
        @@number_of_guesses -= 1
        if @@secret_number - guess > 5
          message = "Way too low! " + number_of_guesses_message
        else
          message = "Too low! " + number_of_guesses_message
        end
      elsif guessed?(guess)
        message = "You got it right! The SECRET NUMBER is #{@@secret_number}. "
        reset_values
        message += "\nNew number has been genereted. " + number_of_guesses_message
      end

      if @@number_of_guesses == 0
        message = "You ran out of guesses. The secret number was #{@@secret_number}. "
        reset_values
        message += "\nNew number has been generated. " + number_of_guesses_message
      end

      message = cheat ? message + " (the secret number is #{@@secret_number})" : message
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

  def reset_values
    @@secret_number = rand(100) + 1
    @@number_of_guesses = 5
  end
end

get '/' do
  guess = params['guess']
  cheat = params['cheat']
  message = generate_message(guess, cheat)
  erb :index, :locals => { :message => message }
end
