require "test_helper"

class MovieTest < ActiveSupport::TestCase
  setup do
    @movie   = movies(:one)
    @review1 = reviews(:one)
    @review2 = reviews(:two)
  end

  test "should return reviews by category" do
    category = @review1.category
    reviews  = @movie.reviews_by_category(category)

    assert_includes reviews, @review1
    assert_not_includes reviews, @review2
  end

  test "should build new reviews for each category" do
    new_reviews = @movie.build_new_reviews

    assert_equal Review.categories.size, new_reviews.size

    new_reviews.each do |review|
      assert_equal @movie, review.movie
    end
  end

  test "should calculate total score" do
    scores      = [3, 4, 5]
    total_score = @movie.calculate_total_score(scores)

    expected_score = 4
    assert_equal expected_score, total_score
  end

  test "should return 0 when calculating total score with no reviews" do
    empty_scores = []

    assert_equal 0, @movie.calculate_total_score(empty_scores)
  end
end
