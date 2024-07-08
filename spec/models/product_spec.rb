require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:cart_products).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:uuid) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
  end

  describe 'uniqueness' do
    subject { create(:product) }
    it { is_expected.to validate_uniqueness_of(:uuid) }
  end
end
