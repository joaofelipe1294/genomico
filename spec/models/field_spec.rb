require 'rails_helper'

RSpec.describe Field, type: :model do

  context 'Field validations' do

  	it 'is expected to create a new field.' do
  		field = create(:field)
  		expect(field).to be_valid
		end

		it 'is expected to fail on try to create a field with empty name' do
			field = build(:field, name: nil)
			field.save
			expect(field).to be_invalid
		end

		it 'is expected to fail on try to create two fields with same name' do
			field = build(:field)
			field.save
			second_field = build(:field, name: field.name)
			second_field.save
			expect(second_field).to be_invalid
			expect(field).to be_valid
		end

	end

	context 'Relations' do

		it { should have_many :offered_exams }

    it { should have_many :internal_codes }

    it { should have_and_belong_to_many :users }

	end

  context 'Field constants' do

    it "FISH" do
      expect(Field.FISH).to eq Field.find_by name: 'FISH'
    end

    it "Biomol" do
      expect(Field.BIOMOL).to eq Field.find_by name: 'Biologia Molecular'
    end

    it "Imunofeno" do
      expect(Field.IMUNOFENO).to eq Field.find_by name: 'Imunofenotipagem'
    end

  end


  it "find issues from field" do
    Rails.application.load_seed
    exams = Exam.create([
        { offered_exam: create(:offered_exam, field: Field.IMUNOFENO)} ,
        { offered_exam: create(:offered_exam, field: Field.IMUNOFENO)} ,
        { offered_exam: create(:offered_exam, field: Field.BIOMOL)} ,
      ])
    expect(Field.IMUNOFENO.set_issues_in_cache.size).to eq 2
    expect(Field.BIOMOL.set_issues_in_cache.size).to eq 1
  end

end
