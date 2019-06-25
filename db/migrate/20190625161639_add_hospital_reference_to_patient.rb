class AddHospitalReferenceToPatient < ActiveRecord::Migration
  def change
  	add_reference :patients, :hospital, foreign_key: true 
  end
end
