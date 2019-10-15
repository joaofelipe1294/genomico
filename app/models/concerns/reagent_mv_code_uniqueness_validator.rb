class ReagentMvCodeUniquenessValidator < ActiveModel::Validator
  def validate(record)
    if record.mv_code && Reagent.where(mv_code: record.mv_code).size > 0
      record.errors[:mv_code] << 'já está em uso'
    end
  end
end
