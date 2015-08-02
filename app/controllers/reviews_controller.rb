class ReviewsController < ApplicationController

  before_filter :find_movie

  def index
    @reviews = @movie.reviews
  end

  def new
    @review = @movie.reviews.new
  end

  def create
    @review = @movie.reviews.new(review_params)
    if @review.save
      redirect_to movie_reviews_path(@movie), notice: "Your review has been added!"
    else
      render :new
      flash[:notice] = @review.errors.full_messages
      flash[:alert] = 'Your review did not save!'
    end
  end

private

  def find_movie
    @movie = Movie.find(params[:movie_id])
  end


  def review_params
    params.require(:review).permit(:name, :stars, :comment, :city, :state, :movie_id)
  end

end
