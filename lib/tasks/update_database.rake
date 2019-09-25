namespace :update_database do

  desc "Remove wrong DNAs and correct dna index"
  task correct_biomol_DNA_index: :environment do

    subsample_19 = Subsample.find 19
    subsample_19.qubit_report.delete
    subsample_19.nanodrop_report.delete
    subsample_19.delete

    subsample_21 = Subsample.find 21
    subsample_21.qubit_report.delete
    subsample_21.nanodrop_report.delete
    subsample_21.delete

    subsample_22 = Subsample.find 22
    subsample_22.qubit_report.delete
    subsample_22.nanodrop_report.delete
    subsample_22.delete

    SubsampleKind.find(2).update({refference_index: 420})

  end




end
