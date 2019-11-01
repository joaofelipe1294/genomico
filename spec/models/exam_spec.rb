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

	context "before update method " do

		before :each do
			Rails.application.load_seed
			@sample = build(:sample, sample_kind: SampleKind.PERIPHERAL_BLOOD)
			@exam = build(:exam, offered_exam: OfferedExam.where(is_active: true).where(field: Field.BIOMOL).first)
			@attendance = create(:attendance, exams: [@exam], samples: [@sample])
			@dna_subsample = create(:subsample, sample: @sample, subsample_kind: SubsampleKind.DNA)
			@exam.exam_status_kind = ExamStatusKind.IN_PROGRESS
		end

		it "with only one subsample dna" do
			@exam.internal_codes = [@dna_subsample.internal_codes.first]
			has_saved = @exam.save
			@exam.reload
			expect(has_saved).to eq true
			expect(@exam.internal_codes.size).to eq 1
		end

		it "with dna and rna BUT only dna will be selected" do
			@rna_subsample = create(:subsample, sample: @sample, subsample_kind: SubsampleKind.RNA)
			@exam.internal_codes = [@rna_subsample.internal_codes.first]
			has_saved = @exam.save
			@exam.reload
			expect(has_saved).to eq true
			expect(@exam.internal_codes.size).to eq 1
		end

		it "with dna and rna BUT only dna will be selected" do
			@rna_subsample = create(:subsample, sample: @sample, subsample_kind: SubsampleKind.RNA)
			@exam.internal_codes = []
			has_saved = @exam.save
			@exam.reload
			expect(has_saved).to eq true
			expect(@exam.internal_codes.size).to eq 2
		end

	end

	context "new attributes validation" do

		it "without was_late" do
			exam = build(:exam, was_late: nil)
			expect(exam).to be_valid
			expect(exam.was_late).to eq false
		end

		it "without lag_time" do
			exam = build(:exam, lag_time: nil)
			expect(exam).to be_valid
			expect(exam.lag_time).to eq 0
		end

	end

	context "check if method thad verofy dalay is okay" do

		it "without delay" do
			exam = create(:exam, offered_exam: OfferedExam.where(refference_date: 5).sample)
			exam.finish_date = 3.days.from_now
			exam.verify_if_was_late
			expect(exam.was_late).to eq false
		end

		it "without delay" do
			exam = create(:exam, offered_exam: OfferedExam.where(refference_date: 5).sample)
			exam.finish_date = 15.days.from_now
			exam.verify_if_was_late
			expect(exam.was_late).to eq true
		end
	
	end

end
