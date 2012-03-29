class MoviesController < ApplicationController

  def index
    @movies = Movie.all.to_a
    k = []
    60.times { @movies.each {|movie| k<< movie}}
    @movies = k
  end

end
