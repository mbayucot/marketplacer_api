require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:promotion).optional }
    it { is_expected.to have_many(:cart_products).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_numericality_of(:subtotal).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:discount).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:total).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:items_count).is_greater_than_or_equal_to(0) }
  end

  describe 'uniqueness' do
    subject { create(:cart) }
    it { is_expected.to validate_uniqueness_of(:user) }
  end
end