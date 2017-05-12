require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100) + 1
number = SECRET_NUMBER

def check_guess(guess)
  unless guess.nil? || guess.empty?
    guess = guess.to_i
    if guess > SECRET_NUMBER
      return "Way too high!" if guess - SECRET_NUMBER > 5
      "Too high!"
    elsif guess < SECRET_NUMBER
      return "Way too low!" if SECRET_NUMBER - guess > 5
      "Too low!"
    elsif guess == SECRET_NUMBER
      "You got it right"
    end
  end
end

get '/' do
  guess = params['guess']
  message = check_guess(guess)
  erb :index, :locals => { :number => number, :message => message }
end
