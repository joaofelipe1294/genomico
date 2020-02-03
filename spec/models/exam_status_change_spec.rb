require 'rails_helper'

RSpec.describe ExamStatusChange, type: :model do

	before(:each) { Rails.application.load_seed }

	context 'Validations' do

		it 'correct' do
			exam_status_change = create(:exam_status_change)
			expect(exam_status_change).to be_valid
		end

		it 'without exam' do
			exam_status_change = build(:exam_status_change, exam: nil)
			exam_status_change.save
			expect(exam_status_change).to be_invalid
		end

		it 'without new_status' do
			exam_status_change = build(:exam_status_change, new_status: nil)
			exam_status_change.save
			expect(exam_status_change).to be_invalid
		end

		it 'without change_date' do
			exam_status_change = build(:exam_status_change, change_date: nil)
			exam_status_change.save
			expect(exam_status_change).to be_valid
		end

		it { should belong_to :user }

	end

end
