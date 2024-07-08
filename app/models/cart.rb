class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :promotion, optional: true
  has_many :cart_products, dependent: :destroy

  validates :user, presence: true, uniqueness: true
  validates :subtotal, :discount, :total, :items_count, numericality: { greater_than_or_equal_to: 0 }
end
