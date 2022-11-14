require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('a'..'z').to_a.sample }
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:score]}"
    dictionnary = URI.open(url).read
    @words = JSON.parse(dictionnary)
    # @answer = "Sorry but #{@words['word']} can't be build out of #{@letter}"
    @letters = params[:authenticity_letters]
    if @words['found'] == true && @words['word'].chars.each {|l| @letters.split(' ').include?('l')}
      @answer = 'You Win'
    else
      @answer = "Sorry but #{@words['word']} can't be build out of #{@letters.split(' ').join(',')}"
    end

  end
end
