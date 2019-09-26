namespace :update_database do

  desc "Update biomol DATA"
  task update_biomol_data: :environment do
    Subsample.create({
      subsample_kind: SubsampleKind.DNA,
      refference_label: "19-DNA-0421",
      sample_id: 119,
      collection_date: Date.today
    })
    Subsample.find(31).destroy
  end

end
