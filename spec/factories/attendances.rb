FactoryBot.define do
  factory :attendance do
  	desease_stage { DeseaseStage.DRM }
  	cid_code { Faker::Number.number(digits: 5).to_s }
  	lis_code { Faker::Number.number(digits: 8).to_s }
  	start_date { Date.current }
  	finish_date { nil }
  	patient { create(:patient) }
  	status { :progress }
  	doctor_name { Faker::Name.name }
  	doctor_crm { Faker::Number.number(digits: 5).to_s }
  	observations { Faker::Lorem.sentence }
  	health_ensurance { HealthEnsurance.all.sample }
  	report { nil }
  	samples_attributes { [attributes_for(:sample)] }
  	exams_attributes { [attributes_for(:exam), attributes_for(:exam) ]}
  end

end
