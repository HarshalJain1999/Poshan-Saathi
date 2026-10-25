class FoodEntry < ApplicationRecord
  belongs_to :user

  enum :meal_type, {
    breakfast: 0,
    lunch: 1,
    snacks: 2,
    dinner: 3
  }

  validates :food_name, presence: true, length: { maximum: 100 }
  validates :food_group, presence: true
  validates :meal_type, presence: true
  validates :eaten_on, presence: true
  validates :quantity, length: { maximum: 50 }, allow_blank: true

  validates :food_group, inclusion: {
    in: %w[grains pulses dairy fruits vegetables protein other]
  }
end
