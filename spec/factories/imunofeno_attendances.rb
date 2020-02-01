FactoryBot.define do
  factory :imunofeno_attendance, class: "Attendance" do
  	desease_stage { :diagnosis }
  	cid_code { Faker::Number.number(digits: 5).to_s }
  	lis_code { Faker::Number.number(digits: 8).to_s }
  	start_date { Date.current }
  	patient { Patient.all.last }
  	status { :progress }
  	doctor_name { "Some doctor" }
  	doctor_crm { "871623" }
  	observations { Faker::Lorem.sentence }
  	health_ensurance { HealthEnsurance.all.sample }
    samples { [build(:imunofeno_sample)] }
    exams { [build(:exam, offered_exam: OfferedExam.where(field: Field.IMUNOFENO).sample)]}
  end

end
