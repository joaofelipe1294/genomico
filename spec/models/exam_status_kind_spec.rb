require 'rails_helper'

RSpec.describe ExamStatusKind, type: :model do

	context 'Validations' do

		it 'Correct' do
			exam_status_kind = create(:exam_status_kind)
			expect(exam_status_kind).to be_valid
		end

		it 'without name' do
			exam_status_kind = build(:exam_status_kind, name: nil)
			expect(exam_status_kind).to be_invalid
		end

		it 'duplicated_name' do
			exam_status_kind = create(:exam_status_kind)
			duplicated = build(:exam_status_kind, name: exam_status_kind.name)
			duplicated.save
			expect(duplicated).to be_invalid
		end

	end

	context 'Relations' do

		it { should have_many(:exams) }

		it { should have_many(:exam_status_changes) }

	end

end
