require 'rails_helper'

RSpec.describe Exam, type: :model do

	context 'Validations' do

		it 'without attendance' do
			exam = build(:exam)
			exam.save
			expect(exam).to be_valid
		end

		it 'without exam_status_kind' do
			exam_status_kind = create(:exam_status_kind, name: 'Aguardando início')
			exam = build(:exam, exam_status_kind: nil)
			exam.save
			expect(exam).to be_valid
			expect(exam.exam_status_kind).to eq(exam_status_kind)
		end

		it 'without finish_date' do
			exam = build(:exam, finish_date: nil)
			exam.save
			expect(exam).to be_valid
		end

		it 'without start_date' do
			exam = build(:exam, start_date: nil)
			exam.save
			expect(exam).to be_valid
			expect(exam.start_date).to eq(nil)
		end

	end

	context 'Relations' do

		it { should belong_to(:attendance) }

		it { should belong_to(:exam_status_kind) }

		it { should belong_to(:offered_exam) }

		it { should have_many(:exam_status_changes) }

    it { should belong_to :internal_code }

	end

end
