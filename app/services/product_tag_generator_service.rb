class ProductTagGeneratorService

  def initialize product
    @product = product
    @stock_product = @product.stock_product
  end

  def call
    return unless @stock_product
    return if @product.tag || @product.has_tag == false
    field_identifier = get_field_identifier
    counter = get_next_index
    "#{field_identifier}#{counter}"
  end

  private

    def get_field_identifier
      field = @stock_product.field
      if field
        field_identifier = field.name[0, 3]
      else
        field_identifier = "ALL"
      end
      field_identifier
    end

    def get_next_index
      products = Product.joins(:stock_product).where(has_tag: true)
      unless @stock_product.field
        products_found = products.where("stock_products.field_id IS NULL")
      else
        products_found = products.where("stock_products.field_id = ?", @stock_product.field_id)
      end
      products_found.size + 1
    end

end
