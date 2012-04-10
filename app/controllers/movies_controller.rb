class MoviesController < ApplicationController
  before_filter :find_movie, :only => [:edit,:update,:destroy, :show]

  def index
    @movies = Movie.where(:language => 2).order_by(:genres.asc).limit(100)
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
