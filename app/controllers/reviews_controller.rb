# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :set_movie, only: %i[ new index create after_create ]

  # GET /movies/:id/reviews/new
  def new
    @reviews = movie.build_new_reviews
  end

  # GET /movies/:id/reviews or /movies/:id/reviews.json
  def index
    @total_score_by_categories = []

    Review.categories.each do |category, _category_index|
      @total_score_by_categories << {
        category:    category.humanize.titleize,
        total_score: movie.calculate_total_score(movie.reviews_by_category(category).pluck(:score))
      }
    end

    @total_score = movie.calculate_total_score
  end

  # POST /movies/:id/reviews
  def create
    @reviews = []

    create_params.each do |review_params|
      reviews << Review.new(review_params.merge(movie_id: movie.id))
    end

    Review.transaction do
      reviews.each(&:save!)

      flash[:created_reviews_ids] = reviews.map(&:id)

      respond_to do |format|
        format.html { redirect_to after_create_movie_reviews_path(movie), notice: "Thank you for your review!" }
        format.json { render json: reviews, status: :created }
      end
    rescue => err
      @error_message = err.message

      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: err, status: :unprocessable_entity }
      end
    end
  end

  def after_create
    @created_reviews_ids = flash[:created_reviews_ids]

    if @created_reviews_ids.nil? || @created_reviews_ids.empty?
      redirect_to(movie_reviews_path(movie))
      return
    end

    @created_reviews = @created_reviews_ids.map { |review_id| Review.find(review_id) }
    @total_score     = movie.calculate_total_score(@created_reviews.map(&:score))
  end

  private
    attr_accessor :movie, :reviews

    def set_movie
      @movie = Movie.find(params[:movie_id])
    end

    def create_params
      params.require(:reviews).map do |review|
        review.permit(:score, :category, :movie_id)
      end
    end
end
