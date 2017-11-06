require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('a' .. 'z').to_a.sample }
  end

  def score
    word = params[:word]
    @letters = params[:letters]
    word_array = word.split("")

    def wordcheck(word)
      url = "https://wagon-dictionary.herokuapp.com/#{word.downcase}"
      word_serialized = open(url).read
      found = JSON.parse(word_serialized)
      found["found"]
    end

    if word_array.all? { |letter| letter.downcase.count(letter) <= @letters.downcase.count(letter) } == false
      @score = "Sorry, but #{word} cannot be built out of #{@letters}"
    elsif !wordcheck(word)
      @score = "Sorry, but #{word} does not seem to be a valid Engish word..."
    else
      @score = "Congratulations! #{word} is a valid English word!"
      # raise
      if session[:points].nil?
        session[:points] = word_array.length
      else
        session[:points] += word_array.length
      end
    end
  end

end


