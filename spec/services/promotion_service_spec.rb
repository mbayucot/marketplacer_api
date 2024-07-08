require 'rails_helper'

RSpec.describe PromotionService do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }
  let(:product1) { create(:product, uuid: 1, name: 'Product 1', price: 10) }
  let(:product2) { create(:product, uuid: 2, name: 'Product 2', price: 30) }
  let(:product3) { create(:product, uuid: 3, name: 'Product 3', price: 60) }

  before do
    Promotion.create!([
                        { threshold: 100, discount: 0.20 },
                        { threshold: 50, discount: 0.15 },
                        { threshold: 20, discount: 0.10 }
                      ])

    cart.cart_products.create(product: product1, quantity: 2)
    cart.cart_products.create(product: product2, quantity: 1)
    cart.cart_products.create(product: product3, quantity: 1)
  end

  describe '#apply_promotions' do
    it 'applies the correct promotion based on the cart total' do
      promotion_service = PromotionService.new(cart)
      promotion_service.apply_promotions

      cart.reload
      expect(cart.subtotal).to eq(110)
      expect(cart.discount).to eq(22)
      expect(cart.total).to eq(88)
      expect(cart.items_count).to eq(4)
    end
  end
end
