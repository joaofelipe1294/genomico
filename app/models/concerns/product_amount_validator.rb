class ProductAmountValidator < ActiveModel::Validator
  def validate(record)
    return if record.amount.nil?
    if record.amount <= 0
      record.errors[:amount] << 'deve ser maior que zero'
    end
  end
end
