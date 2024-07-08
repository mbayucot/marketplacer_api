class Promotion < ApplicationRecord
  has_one :cart

  validates :threshold, presence: true
  validates :discount, presence: true
end
