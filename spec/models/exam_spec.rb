require 'rails_helper'

RSpec.describe Exam, type: :model do
  
	context 'Validations' do

		it 'without attendance' do
			exam = build(:exam)
			exam.save
			expect(exam).to be_invalid
		end

	end

end
