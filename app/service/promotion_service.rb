class PromotionService

  def initialize(cart)
    @cart = cart
  end

  def apply_promotions
    subtotal = calculate_subtotal
    promotion = find_promotion(subtotal)
    discount = calculate_discount(subtotal, promotion)
    total = calculate_total(subtotal, discount)
    items_count = calculate_items_count

    update_cart(subtotal, discount, total, items_count, promotion)
  end

  private

  def calculate_subtotal
    @cart.cart_products.joins(:product).sum('products.price * cart_products.quantity')
  end

  def find_promotion(subtotal)
    Promotion.where('threshold <= ?', subtotal).order(threshold: :desc).first
  end

  def calculate_discount(subtotal, promotion)
    promotion ? subtotal * promotion.discount : 0
  end

  def calculate_total(subtotal, discount)
    subtotal - discount
  end

  def calculate_items_count
    @cart.cart_products.sum(:quantity)
  end

  def update_cart(subtotal, discount, total, items_count, promotion)
    @cart.update!(
      subtotal: subtotal,
      discount: discount,
      total: total,
      items_count: items_count,
      promotion: promotion
    )
  end
end
