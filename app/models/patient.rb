class Patient < ActiveRecord::Base
	belongs_to :hospital
	has_many :attendances
	paginates_per 10
	validates :name, :hospital_id, :birth_date, presence: true
	validate :medical_record_presence_validation
	validates :medical_record, uniqueness: {scope: :hospital_id}
	validates :name, uniqueness: {scope: [:hospital_id, :birth_date]}
	has_many :samples
	has_many :subsamples

	private

		def medical_record_presence_validation
			if (self.medical_record.nil? && self.hospital == Hospital.HPP) || (self.medical_record.strip.empty? && self.hospital == Hospital.HPP)
				self.errors.add(:medical_record, "não pode ficar em branco.")
			end
		end

		def medical_record_uniqueness_validation
			patients = Patient.find_by(hospital: self.hospital, medical_record: self.medical_record)
			if patients.size > 0
				self.errors.add(:medical_record, "já está sendo utilizado.")
			end
		end

end
