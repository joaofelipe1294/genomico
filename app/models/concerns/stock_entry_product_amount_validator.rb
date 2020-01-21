class StockEntryProductAmountValidator < ActiveModel::Validator

  def validate record
    return unless record.product_amount
    if record.product_amount <= 0
      record.errors[:product_amount] << "deve ser maior do que zero"
    end
  end

end
