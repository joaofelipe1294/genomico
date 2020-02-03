require 'rails_helper'

RSpec.describe Attendance, type: :model do

	context 'Validations' do

		before :each do
			Rails.application.load_seed
		end

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

		it 'without status' do
			attendance = build(:attendance, status: nil)
			attendance.save
			expect(attendance).to be_valid
			expect(attendance.status).to eq :progress.to_s
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

		it { should belong_to(:health_ensurance) }

		it { should have_many(:exams) }

		it { should have_many(:samples) }

		it { should have_and_belong_to_many(:work_maps) }

	 	it { should accept_nested_attributes_for(:samples) }

 	 	it { should accept_nested_attributes_for(:exams) }

		it { should have_many :internal_codes }

	end

	describe "attendance#has_pendent_reports?" do

		before :each do
			Rails.application.load_seed
			patient = create(:patient)
		end

	  context "when has only one exam" do

			before :each do
				first_exam = build(:exam, offered_exam: create(:offered_exam, field: Field.BIOMOL))
				@attendance = create(:attendance, exams: [first_exam])
				@exam = @attendance.exams.first
			end

    	context "when exam is in progress" do
    	  it "is expected to return false" do
					@exam.update exam_status_kind: ExamStatusKind.IN_PROGRESS
					expect(@attendance.reload.has_pendent_reports?).to be_falsy
    	  end
    	end
			context "when exam is in_repeat" do
			  it "is expected to return false" do
			  	@exam.update exam_status_kind: ExamStatusKind.IN_REPEAT
					expect(@attendance.reload.has_pendent_reports?).to be_falsy
			  end
			end
			context "when exam is complete" do
		  	it "is expected to return false" do
		  		@exam.update exam_status_kind: ExamStatusKind.COMPLETE
					expect(@attendance.reload.has_pendent_reports?).to be_falsy
		  	end
			end
			context "when exam is complete without report" do
		  	it "is expected to return true" do
		  		@exam.update exam_status_kind: ExamStatusKind.COMPLETE_WITHOUT_REPORT
					expect(@attendance.reload.has_pendent_reports?).to be_truthy
		  	end
			end
	  end
		context "when attendance has more than one exam" do
			before :each do
				first_exam = build(:exam, offered_exam: create(:offered_exam, field: Field.BIOMOL))
				second_exam = build(:exam, offered_exam: create(:offered_exam, field: Field.BIOMOL))
				@attendance = create(:attendance, exams: [first_exam, second_exam])
				@first_exam = @attendance.reload.exams.first
				@second_exam = @attendance.reload.exams.last
			end
			context "when one is complete and other in progress" do
		  	it "is expected to return false" do
	  			@first_exam.update exam_status_kind: ExamStatusKind.COMPLETE
					@second_exam.update exam_status_kind: ExamStatusKind.IN_PROGRESS
					expect(@attendance.reload.has_pendent_reports?).to be_falsy
		  	end
			end
			context "when one is complete without report and other complete" do
			  it "is expected to return true" do
			  	@first_exam.update exam_status_kind: ExamStatusKind.COMPLETE_WITHOUT_REPORT
					@second_exam.update exam_status_kind: ExamStatusKind.COMPLETE
					expect(@attendance.reload.has_pendent_reports?).to be_truthy
			  end
			end
			context "when one is complete without report and other in progress" do
				it "is expected to return false" do
					@first_exam.update exam_status_kind: ExamStatusKind.COMPLETE_WITHOUT_REPORT
					@second_exam.update exam_status_kind: ExamStatusKind.IN_PROGRESS
					expect(@attendance.reload.has_pendent_reports?).to be_falsy
				end
			end
		end
	end

end
