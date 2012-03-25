class MoviesController < ApplicationController

  def index
    @movies = Movie.all.to_a
    k = []
    20.times { @movies.each {|movie| k<< movie}}
    @movies = k
  end

end
