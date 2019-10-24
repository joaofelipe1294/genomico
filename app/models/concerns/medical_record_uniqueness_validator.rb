class MedicalRecordUniquenessValidator < ActiveModel::Validator

  def validate record
    if record.medical_record != ""
      patients_with_same_medical_record = Patient.
                                                  where(medical_record: record.medical_record).
                                                  where(hospital: record.hospital).
                                                  where.not(id: record.id).
                                                  where.not(id: record.id).
                                                  size
      record.errors[:medical_record] << "já está em uso" if patients_with_same_medical_record > 0
    end
  end

end
