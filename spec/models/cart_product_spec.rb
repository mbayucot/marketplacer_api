require 'rails_helper'

RSpec.describe CartProduct, type: :model do
  describe 'validations' do
    it { is_expected.to belong_to(:cart) }
    it { is_expected.to belong_to(:product) }
  end

  describe 'callbacks' do
    let(:cart) { create(:cart) }
    let(:product) { create(:product) }
    let(:cart_product) { build(:cart_product, cart: cart, product: product) }
    let(:promotion_service) { instance_double("PromotionService") }

    before do
      allow(PromotionService).to receive(:new).with(cart).and_return(promotion_service)
      allow(promotion_service).to receive(:apply_promotions)
    end

    it 'calls apply_promotions after save' do
      cart_product.save
      expect(promotion_service).to have_received(:apply_promotions)
    end
  end
end
