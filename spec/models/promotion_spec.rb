require 'rails_helper'

RSpec.describe Promotion, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:threshold) }
    it { is_expected.to validate_presence_of(:discount) }
  end
end
