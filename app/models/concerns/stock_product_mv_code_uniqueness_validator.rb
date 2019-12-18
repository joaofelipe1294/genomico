class StockProductMvCodeUniquenessValidator < ActiveModel::Validator
  def validate(record)
    return if record.mv_code == ""
    if record.mv_code && StockProduct.where(mv_code: record.mv_code).where.not(id: record.id).size > 0
      record.errors[:mv_code] << 'já está em uso'
    end
  end
end
