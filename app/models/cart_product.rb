class CartProduct < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  after_save :apply_promotions

  private

  def apply_promotions
    PromotionService.new(cart).apply_promotions
  end
end
