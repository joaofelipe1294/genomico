class RelationateSamplesToPatients < ActiveRecord::Migration[5.2]
  def change
    Sample.includes(:attendance).all.each do |sample|
      unless sample.attendance.nil?
        sample.patient = sample.attendance.patient
        sample.save
      end
    end

    Subsample.all.includes(:attendance).each do |subsample|
      unless subsample.attendance.nil?
        subsample.patient = subsample.attendance.patient
        subsample.save
      end
    end

  end
end
