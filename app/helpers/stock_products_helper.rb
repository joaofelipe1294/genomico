module StockProductsHelper

  def display_field stock_product
    field = stock_product.field
    if field
      content = field.name
    else
      content = "Compartilhado"
    end
    "<label>#{content}</label>".html_safe
  end

end
