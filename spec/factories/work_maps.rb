FactoryBot.define do
  factory :work_map do
    name { Faker::Company.name }
    date { Faker::Date.between(2.days.ago, Date.today) }
    map { File.new(Rails.root + 'spec/support_files/PDF.pdf') }
    attendances { [create(:attendance), create(:attendance)] }
  end
end
