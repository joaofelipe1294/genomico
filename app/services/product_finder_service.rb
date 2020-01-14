class ProductFinderService

  def initialize product
    @product = product
  end

  def call
    products = Product
                      .where(current_state: CurrentState.STOCK)
                      .where(stock_product_id: @product.stock_product_id)
                      .where.not(id: @product.id)
    if @product.has_shelf_life
      next_product = products.order(shelf_life: :asc).first
    else
      next_product = products.order(tag: :asc).first
    end
    next_product
  end

end
