require "test_helper"

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movie  = movies(:one)
    @review = reviews(:one)
  end

  test "should get index" do
    get movie_reviews_url(@movie)

    assert_response :success

    assert_not_nil assigns(:total_score)
    assert_not_nil assigns(:total_score_by_categories)
  end

  test "should get new" do
    get new_movie_review_url(@movie)

    assert_response :success

    assert_not_nil assigns(:reviews)
  end

  test "should create review" do
    assert_difference("Review.count", 1) do
      post movie_reviews_url(@movie), params: {
        reviews: [
          { score: 4, category: "performance", movie_id: @movie.id }
        ]
      }
    end

    assert_redirected_to after_create_movie_reviews_url(@movie)
  end

  test "should not create review with invalid params" do
    assert_no_difference("Review.count") do
      post movie_reviews_url(@movie), params: {
        reviews: [
          { score: nil, category: "performance", movie_id: @movie.id }
        ]
      }
    end

    assert_response :unprocessable_entity
  end

  test "should get after_create" do
    post movie_reviews_url(@movie), params: {
      reviews: [
        { score: 4, category: "performance", movie_id: @movie.id }
      ]
    }

    follow_redirect!

    assert_response :success

    assert_not_nil assigns(:created_reviews)
  end


  test "should get index with JSON" do
    get movie_reviews_url(@movie), as: :json

    assert_response :success

    json_response = JSON.parse(@response.body)

    assert_equal 5, json_response["total_score"]

    assert json_response["total_score_by_categories"].is_a?(Array)
  end

  test "should create review with JSON" do
    assert_difference("Review.count", 1) do
      post movie_reviews_url(@movie), params: {
        reviews: [
          { score: 4, category: "performance", movie_id: @movie.id }
        ]
      }, as: :json
    end

    assert_response :created

    json_response = JSON.parse(@response.body)

    assert json_response.is_a?(Array)

    assert_equal 1, json_response.size
    assert_equal "performance", json_response.first["category"]
    assert_equal 4, json_response.first["score"]
  end

  test "should not create review with invalid params and JSON" do
    assert_no_difference("Review.count") do
      post movie_reviews_url(@movie), params: {
        reviews: [
          { score: nil, category: "performance", movie_id: @movie.id }
        ]
      }, as: :json
    end

    assert_response :unprocessable_entity

    json_response = JSON.parse(@response.body)

    assert_equal json_response, "Validation failed: Score can't be blank, Score must be between 1 and 5"
  end
end
