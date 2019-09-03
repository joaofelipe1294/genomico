class AddReferenceBetweenPatientAndSubsamples < ActiveRecord::Migration[5.2]
  def change
    add_reference :subsamples, :patient, foreign_key: true

    Subsample.includes(:attendance).all.each do |subsample|
      subsample.patient = subsample.attendance.patient unless subsample.attendance.nil?
      subsample.save
    end

  end

end
