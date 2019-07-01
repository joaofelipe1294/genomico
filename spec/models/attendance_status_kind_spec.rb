require 'rails_helper'

RSpec.describe AttendanceStatusKind, type: :model do

  context 'Validations' do

  	it 'correct' do
  		attendance_status_kind = create(:attendance_status_kind)
  		expect(attendance_status_kind).to be_valid
		end

		it 'without name' do
			attendance_status_kind = build(:attendance_status_kind, name: nil)
			attendance_status_kind.save
			expect(attendance_status_kind).to be_invalid
		end

		it 'duplicated name' do
			attendance_status_kind = create(:attendance_status_kind)
			duplicated = build(:attendance_status_kind, name: attendance_status_kind.name)
			duplicated.save
			expect(duplicated).to be_invalid
		end

	end

	context 'relations' do

		it { should have_many(:attendances) }

	end

end
