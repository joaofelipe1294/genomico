class Patient < ActiveRecord::Base
	validates :medical_record, uniqueness: true	
end
