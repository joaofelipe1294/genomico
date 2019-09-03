class AddReferenceBetweenPatientAndSamples < ActiveRecord::Migration[5.2]
  def change
    add_reference :samples, :patient, foreign_key: true
    
    Sample.includes(:attendance).all.each do |sample|
      sample.patient = sample.attendance.patient unless sample.attendance.nil?
      sample.save
    end

  end
end
