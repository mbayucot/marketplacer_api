class CartsController < ApplicationController
  before_action :set_cart, only: [:index, :add_product, :items_count]

  def index
    render json: {
      products: @cart.cart_products.map do |cp|
        {
          id: cp.product.id,
          name: cp.product.name,
          price: cp.product.price,
          quantity: cp.quantity
        }
      end,
      summary: @cart.as_json(only: %i[subtotal total discount items_count]),
      promotion_message: promotion_message(@cart.promotion)
    }
  end

  def items_count
    render json: { total: @cart.items_count }
  end

  def add_product
    product = Product.find(params[:product_id])
    quantity = params[:quantity] || 1

    cart_product = @cart.cart_products.find_or_initialize_by(product: product)
    cart_product.quantity ||= 0
    cart_product.quantity += quantity.to_i
    cart_product.save!

    render json: @cart.as_json(only: %i[subtotal total discount items_count]), status: :created
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end

  def promotion_message(promotion)
    return nil unless promotion

    discount_percentage = (promotion.discount * 100).to_i
    "Discount applied: #{discount_percentage}% off on total greater than $#{promotion.threshold}"
  end
end
