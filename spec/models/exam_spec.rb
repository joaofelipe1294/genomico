require 'rails_helper'

RSpec.describe Exam, type: :model do

	context 'Validations' do

		before :all do
			Rails.application.load_seed
		end

		it 'without attendance' do
			exam = build(:exam)
			exam.save
			expect(exam).to be_valid
		end

		it 'without exam_status_kind' do
			exam = build(:exam, exam_status_kind: nil)
			exam.save
			expect(exam).to be_valid
			expect(exam.exam_status_kind).to eq(ExamStatusKind.WAITING_START)
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

		it "without offered_exam" do
			exam = build(:exam, offered_exam: nil)
			expect(exam).to be_invalid
		end

	end

	context 'Relations' do

		it { should belong_to(:attendance) }

		it { should belong_to(:exam_status_kind) }

		it { should belong_to(:offered_exam) }

		it { should have_many(:exam_status_changes) }

    it { should have_and_belong_to_many :internal_codes }

	end

end
