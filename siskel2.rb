require 'httparty'

class Siskel
  attr_reader :title, :rating, :plot, :year, :consensus


  def initialize(title, options = {} )
    @movie = HTTParty.get("http://www.omdbapi.com/?t=#{title}&y=#{options[:year]}&plot=#{options[:plot]}")



    @rating = @movie['Rated']
    @year = @movie['Year']
    @plot = @movie['Plot']
    @consensus = @movie['Metascore'].to_i
    if @consensus.between?(76, 100)
      @consensus = "Two Thumbs Up"
    elsif @consensus.between?(51, 75)
      @consensus = "Thumbs Up"
    elsif @consensus.between?(26, 50)
      @consensus = "Thumbs Down"
    else
      @consensus = "Two Thumbs Down"
    end


    if @movie['Title'].nil?
      @title = "Movie not found!"

    else
      @title = @movie['Title']
    end
  end


end
