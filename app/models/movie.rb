# frozen_string_literal: true

class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy

  def reviews_by_category(category)
    reviews.by_category(category)
  end

  def build_new_reviews
    Review.categories.map do |category, _category_index|
      Review.new(movie: self, category: category)
    end
  end

  def calculate_total_score(scores = reviews.pluck(:score))
    begin
      (scores.sum.to_f / scores.size.to_f).to_i
    rescue
      0
    end
  end
end
