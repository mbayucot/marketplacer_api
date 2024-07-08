require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Products API', type: :request do
  let(:user) { create(:user) }
  let!(:products) { create_list(:product, 10) }
  let(:product_id) { products.first.id }

  let(:valid_headers) do
    Devise::JWT::TestHelpers.auth_headers({ Accept: 'application/json' }, user)
  end

  describe 'GET /products' do
    it 'returns a list of products' do
      get products_path, headers: valid_headers

      expect(response).to have_http_status(:ok)
      expect(json.length).to eq(10)
      expect(json[0]).to have_key('id')
      expect(json[0]).to have_key('name')
      expect(json[0]).to have_key('price')
      expect(json[0]).to have_key('uuid')
    end
  end

  describe 'GET /products/:id' do
    before { get "/products/#{product_id}", headers: valid_headers }

    context 'when the product exists' do
      it 'returns the product' do
        expect(response).to have_http_status(:ok)
        expect(json).not_to be_empty
        expect(json['id']).to eq(product_id)
      end
    end

    context 'when the product does not exist' do
      let(:product_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
        expect(response.body).to match(/Couldn't find Product/)
      end
    end
  end
end
