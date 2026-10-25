class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  enum :role, {
    student: 0,
    admin: 1
  }

  has_many :food_entries, dependent: :destroy

  before_validation :normalize_email

  validates :name, presence: true

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end
end
