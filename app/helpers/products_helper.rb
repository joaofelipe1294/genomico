module ProductsHelper

  def display_shelf_life product
    expired_message = "<span class='text-danger'>#{I18n.localize product.shelf_life}</span>".html_safe
    return expired_message if product.is_expired
    if product.shelf_life < Date.current
      product.update(is_expired: true)
      return expired_message
    else
      return "<span>#{I18n.localize product.shelf_life}</span>".html_safe
    end
  end

  def display_tag product
    return product.tag if product.has_tag
    "-"
  end

end
