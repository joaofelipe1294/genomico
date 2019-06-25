class Patient < ActiveRecord::Base
	validates :medical_record, uniqueness: true	
	validates :name, :birth_date, :mother_name, :medical_record, :hospital, presence: true 
	validates :name, uniqueness: {scope: [:birth_date, :mother_name], allow_blank: false}
	paginates_per 10
	has_many :attendances
	belongs_to :hospital
end