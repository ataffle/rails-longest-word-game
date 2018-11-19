require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    @alphabet = ("A".."Z").to_a
    @grid = []
    10.times do |letter|
      @grid << @alphabet.sample
    end
  end

  def score
    @word = params[:word].upcase.split
    @english_word = params[:word]
    @letters = params[:letters]
    @check_grid = check_grid(@letters, @word)
    @check_english = check_english(@english_word)
  end

  def check_grid(letters, word)
    word.all? do |letter|
      word.count(letter) <= letters.count(letter)
    end
  end

  def check_english(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    test_serialized = open(url).read
    test = JSON.parse(test_serialized)
    test["found"]
  end

end
