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

  def display_total_aviable stock_product
      "<span class='text-#{text_color(stock_product.total_aviable)}'>#{stock_product.total_aviable}  (#{stock_product.unit_of_measurement_name})</span>".html_safe
  end

  def display_total_in_use stock_product
    "<span class='text-#{text_color(stock_product.total_in_use)}'>#{stock_product.total_in_use}  (#{stock_product.unit_of_measurement_name})</span>".html_safe
  end

  private

    def text_color value
      if value > 0
        "dark"
      else
        "danger"
      end
    end

end
