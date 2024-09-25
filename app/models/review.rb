# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :movie

  MIN_SCORE = 1
  MAX_SCORE = 5

  enum category: {
    performance:     0,
    special_effects: 1,
    storytelling:    2,
  }

  scope :by_category, ->(category) { where(category: category) }

  validates :score, presence: true, numericality: {
    greater_than_or_equal_to: MIN_SCORE,
    less_than_or_equal_to:    MAX_SCORE,
    message:                  "must be between #{MIN_SCORE} and #{MAX_SCORE}"
  }

  def humanized_category
    category&.humanize&.titleize
  end
end
