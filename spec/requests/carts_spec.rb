require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Carts API', type: :request do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }
  let(:product) { create(:product) }

  let(:valid_headers) do
    Devise::JWT::TestHelpers.auth_headers({ Accept: 'application/json' }, user)
  end

  let(:valid_attributes) {
    { product_id: product.id }
  }

  let(:invalid_attributes) {
    { product_id: nil }
  }

  describe 'GET /carts' do
    context 'when the request is valid' do
      before do
        cart.cart_products.create(product: product, quantity: 2)
      end

      it 'returns the cart details' do
        get carts_path, headers: valid_headers

        expect(response).to have_http_status(:ok)
        expect(json['products'].length).to eq(1)
        expect(json['summary']).to include('subtotal', 'discount', 'total', 'items_count')
        expect(json).to include('promotion_message')
      end
    end
  end

  describe 'POST /carts/add_product' do
    context 'with valid parameters' do
      it 'adds a product to the cart and applies promotions' do
        expect {
          post add_product_carts_path, params: valid_attributes, headers: valid_headers
        }.to change(CartProduct, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(json).to include('subtotal', 'discount', 'total', 'items_count')
      end
    end
  end

  describe 'GET /carts/items_count' do
    it 'returns the total quantity of products in the cart' do
      cart.cart_products.create(product: product, quantity: 2)

      get items_count_carts_path, headers: valid_headers

      expect(response).to have_http_status(:ok)
      expect(json['total']).to eq(2)
    end
  end
end
