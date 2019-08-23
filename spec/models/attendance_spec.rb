require 'rails_helper'

RSpec.describe Attendance, type: :model do

	context 'Validations' do

		it 'correct' do
			attendance = build(:attendance)
			expect(attendance).to be_valid
		end

		it 'without desease_stage' do
			attendance = build(:attendance, desease_stage: nil)
			attendance.save
			expect(attendance).to be_invalid
		end

		it 'without cid_code' do
			attendance = build(:attendance, cid_code: nil)
			attendance.save
			expect(attendance).to be_valid
		end

		it 'withot lis_code' do
			attendance = build(:attendance, lis_code: nil)
			attendance.save
			expect(attendance).to be_invalid
		end

		it 'duplicated lis_code' do
			attendance = create(:attendance)
			duplicated = build(:attendance, lis_code: attendance.lis_code)
			duplicated.save
			expect(duplicated).to be_invalid
			expect(attendance).to be_valid
		end

		it 'without start_date' do
			attendance = build(:attendance, start_date: nil)
			attendance.save
			expect(attendance).to be_valid
			attendance = Attendance.last
			expect(attendance.start_date.to_date).to eq(Date.today)
		end

		it 'without finish_date' do
			attendance = build(:attendance, finish_date: nil)
			attendance.save
			expect(attendance).to be_valid
			attendance = Attendance.last
			expect(attendance.finish_date).to be_falsy
		end

		it 'without patient' do
			attendance = build(:attendance, patient: nil)
			attendance.save
			expect(attendance).to be_invalid
		end

		it 'without attendance_status_kind' do
			attendance_status_kind = create(:attendance_status_kind, name: 'Em andamento')
			attendance = build(:attendance, attendance_status_kind: nil)
			attendance.save
			expect(attendance).to be_valid
			expect(attendance.attendance_status_kind).to eq(attendance_status_kind)
		end

		it 'without doctor_name' do
			attendance = build(:attendance, doctor_name: nil)
			attendance.save
			expect(attendance).to be_valid
		end

		it 'without doctor_crm' do
			attendance = build(:attendance, doctor_crm: nil)
			attendance.save
			expect(attendance).to be_valid
		end

		it 'without observations' do
			attendance = build(:attendance, observations: nil)
			attendance.save
			expect(attendance).to be_valid
		end

		it 'without health_ensurance' do
			attendance = build(:attendance, health_ensurance: nil)
			attendance.save
			expect(attendance).to be_valid
		end

		it 'without exams' do
			attendance = build(:attendance, exams_attributes: {})
			attendance.save
			expect(attendance).to be_invalid
		end

		it 'without samples' do
			attendance = build(:attendance, samples_attributes: {})
			attendance.save
			expect(attendance).to be_invalid
		end

	end

	context 'Relations' do

		it { should belong_to(:patient) }

		it { should belong_to(:attendance_status_kind) }

		it { should belong_to(:health_ensurance) }

		it { should have_many(:exams) }

		it { should have_many(:samples) }

		it { should have_and_belong_to_many(:work_maps) }

	 	it { should accept_nested_attributes_for(:samples) }

 	 	it { should accept_nested_attributes_for(:exams) }

		it { should have_many :internal_codes }

	end

end
