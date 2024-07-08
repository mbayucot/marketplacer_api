class Product < ApplicationRecord
  has_many :cart_products, dependent: :destroy

  validates :uuid, :name, :price, presence: true
  validates :uuid, uniqueness: true
end
