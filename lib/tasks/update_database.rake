namespace :update_database do
  desc "Atualiza o valor de referência das subsamples"
  task update_biomol_subsample_indexes: :environment do
    subsample = Subsample.find 15
    subsample.nanodrop_report.delete
    subsample.qubit_report.delete
    subsample.delete
    SubsampleKind.find_by(acronym: 'CMV').update({refference_index: 835})
    SubsampleKind.find_by(acronym: 'DNA').update({refference_index: 419})
    SubsampleKind.find_by(acronym: 'RNA').update({refference_index: 311})
    # SubsampleKind.find_by(acronym: 'FISH').update({refference_index: 226})
  end

  desc "Remove old attendances"
  task remove_biomol_attendances: :environment do
    attendance_27 = Attendance.find 27
    attendance_27.exams.each do |exam|
      exam.exam_status_changes.delete_all
      exam.delete
    end
    attendance_27.samples.each do |sample|
      sample.subsamples.each do |subsample|
        subsample.qubit_report.delete
        subsample.nanodrop_report.delete
        subsample.delete
      end
      sample.delete
    end
    attendance_27.delete

    attendance_2 = Attendance.find 2
    attendance_2.exams.each do |exam|
      exam.exam_status_changes.delete_all
      exam.delete
    end
    attendance_2.samples.each do |sample|
      sample.subsamples.each do |subsample|
        subsample.qubit_report.delete
        subsample.nanodrop_report.delete
        subsample.delete
      end
      sample.delete
    end
    attendance_2.delete

    attendance_1 = Attendance.find 1
    attendance_1.exams.each do |exam|
      exam.exam_status_changes.delete_all
      exam.delete
    end
    attendance_1.samples.each do |sample|
      sample.subsamples.each do |subsample|
        subsample.qubit_report.delete
        subsample.nanodrop_report.delete
        subsample.delete
      end
      sample.delete
    end
    attendance_1.delete
  end

end
