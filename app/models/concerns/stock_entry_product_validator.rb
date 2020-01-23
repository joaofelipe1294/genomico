class StockEntryProductValidator < ActiveModel::Validator

  def validate record
    product = record.product
    unless product
      record.errors["Produto"] << "não pode ficar em branco"
    else
      unless product.valid?
        product.errors.each do |error|
          record.errors[error.to_sym] << product.errors.messages[error.to_sym].first
        end
      end
    end
  end

end
