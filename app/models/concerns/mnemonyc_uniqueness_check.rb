class MnemonycUniquenessCheck < ActiveModel::Validator
  def validate(record)
    if record.mnemonyc.present? && OfferedExam.where(mnemonyc: record.mnemonyc).where.not(id: record.id).size > 0
      record.errors[:mnemonyc] << 'já está em uso'
    end
  end
end
