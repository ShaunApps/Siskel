require 'httparty'

class Siskel
  attr_reader :title, :rating, :plot, :year, :consensus


  def initialize(title, options = {} )
    if options.nil?
      @movie = HTTParty.get("http://www.omdbapi.com/?t=#{title}")
    else
      @movie = HTTParty.get("http://www.omdbapi.com/?t=#{title}&plot=full")
    end



    @rating = @movie['Rated']
    @year = options
    @plot = options

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

###^^^^^^initialize




  def year
    if @year[:year].nil?
      @year = @movie['Year']
    else
      @year = @year[:year].to_s
    end
  end


  def plot
    @plot = @movie['Plot']
  end

end
