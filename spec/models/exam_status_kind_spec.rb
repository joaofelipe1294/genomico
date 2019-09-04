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

	context "constants" do

		before :all do
			Rails.application.load_seed
		end

		it "waiting_start" do
			expect(ExamStatusKind.WAITING_START).to eq ExamStatusKind.find_by name: 'Aguardando início'
		end

		it "in_progress" do
			expect(ExamStatusKind.IN_PROGRESS).to eq ExamStatusKind.find_by name: 'Em andamento'
		end

		it "tecnical_released" do
			expect(ExamStatusKind.TECNICAL_RELEASED).to eq ExamStatusKind.find_by name: 'Liberado técnico'
		end

		it "in_repeat" do
			expect(ExamStatusKind.IN_REPEAT).to eq ExamStatusKind.find_by name: 'Em repetição'
		end

		it "complete" do
			expect(ExamStatusKind.COMPLETE).to eq ExamStatusKind.find_by name: 'Concluído'
		end

	end

end
