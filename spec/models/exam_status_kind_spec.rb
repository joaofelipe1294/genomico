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

		it "partial_released" do
			expect(ExamStatusKind.PARTIAL_RELEASED).to eq ExamStatusKind.find_by name: 'Liberado parcial'
		end

		it "complete without report" do
			expect(ExamStatusKind.COMPLETE_WITHOUT_REPORT).to eq ExamStatusKind.find_by name: 'Concluído (sem laudo)'
		end

		it "canceled" do
			expect(ExamStatusKind.CANCELED).to eq ExamStatusKind.find_by name: "Cancelado"
		end

	end

	context "display colors" do

		before :each do
			Object.send(:remove_const, :ExamStatusKinds) if Module.const_defined?(:ExamStatusKinds)
	    load 'app/models/concerns/exam_status_kinds.rb'
		end

		it "in repeat" do
			expect(ExamStatusKind.IN_REPEAT.display_name).to eq "<label class='text-warning'>#{ExamStatusKind.IN_REPEAT.name}</label>"
		end

		it "waiting_start" do
			expect(ExamStatusKind.WAITING_START.display_name).to eq "<label class=''>#{ExamStatusKind.WAITING_START.name}</label>"
		end

		it "in_progress" do
			expect(ExamStatusKind.IN_PROGRESS.display_name).to eq "<label class='text-primary'>#{ExamStatusKind.IN_PROGRESS.name}</label>"
		end

		it "tecnical_released" do
			expect(ExamStatusKind.TECNICAL_RELEASED.display_name).to eq "<label class='text-secondary'>#{ExamStatusKind.TECNICAL_RELEASED.name}</label>"
		end

		it "complete" do
			expect(ExamStatusKind.COMPLETE.display_name).to eq "<label class='text-success'>#{ExamStatusKind.COMPLETE.name}</label>"
		end

		it "partial_released" do
			expect(ExamStatusKind.PARTIAL_RELEASED.display_name).to eq "<label class='text-info'>#{ExamStatusKind.PARTIAL_RELEASED.name}</label>"
		end

		it "complete without report" do
			expect(ExamStatusKind.COMPLETE_WITHOUT_REPORT.display_name).to eq "<label class='text-dark'>#{ExamStatusKind.COMPLETE_WITHOUT_REPORT.name}</label>"
		end

		it "canceled" do
			expect(ExamStatusKind.CANCELED.display_name).to eq "<label class='text-danger'>#{ExamStatusKind.CANCELED.name}</label>"
		end

	end

end
