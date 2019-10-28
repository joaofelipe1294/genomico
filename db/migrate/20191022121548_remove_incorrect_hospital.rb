class RemoveIncorrectHospital < ActiveRecord::Migration[5.2]
  def change
    wrong_hospital = Hospital.find 4
    patient = Patient.find 139
    correct_hospital = Hospital.find 6
    patient.hospital = correct_hospital
    patient.save
    wrong_hospital.delete
  end
end
