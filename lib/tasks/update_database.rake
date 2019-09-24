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

end
