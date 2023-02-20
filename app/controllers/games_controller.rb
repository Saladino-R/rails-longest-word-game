class GamesController < ApplicationController
  require 'json'
  require 'open-uri'

  def new
    array = ('a'..'z').to_a
    @letters = array.sample(10)
  end

  def score
    @words = params[:word]

    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    user_serialized = URI.open(url).read
    @user = JSON.parse(user_serialized)

    @letters = params[:letters].split

    if @letters.include?(@words)
      @result = "CONGRATULATIONS ! #{@words} is a valid English word !"
    elsif @user['found'] == false
      @result = "Sorry but #{@words} doest not the seem to be a valid English word..."
    else
      @result = "Sorry but #{@words} can't be build out of #{@letters}"
    end
  end
end
