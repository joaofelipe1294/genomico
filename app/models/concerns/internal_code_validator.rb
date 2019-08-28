class InternalCodeValidator < ActiveModel::Validator
  def validate(record)
    if record.subsample.nil? && record.field == Field.find_by(name: 'Biologia Molecular')
      record.errors[:internal_code] << 'A biologia molecular pode gerar códigos internos apenas para subamostras.'
    end
  end
end
