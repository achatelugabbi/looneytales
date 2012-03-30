class MoviesController < ApplicationController
  before_filter :find_movie, :only => [:edit,:update,:destroy, :show]

  def index
    @movies = Movie.all.to_a
    k = []
    60.times { @movies.each {|movie| k<< movie}}
    @movies = k
  end

  
  def find_movie
    @movie = Movie.where(:_id => params[:id]).first
    if @movie.nil?
      redirect_to "/movies", :notice => "Can not find movie"
      return false
    end
  end
  protected :find_movie
end
