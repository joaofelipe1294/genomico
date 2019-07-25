class Patient < ActiveRecord::Base
	belongs_to :hospital
	has_many :attendances
	paginates_per 10
	validates :name, :hospital_id, :birth_date, presence: true
	validate :mother_name_validation
	validate :medical_record_presence_validation
	validates :medical_record, uniqueness: {scope: :hospital_id}
	validates :name, uniqueness: {scope: [:hospital_id, :mother_name, :birth_date]}

	private

		def mother_name_validation
			hpp = Hospital.find_by name: "Hospital Pequeno Príncipe"
			if (self.mother_name.nil? && self.hospital == hpp) || (self.mother_name.strip.empty? && self.hospital == hpp)
				self.errors.add(:mother_name, "O nome da mãe não pode ficar em branco.")
			end
		end

		def medical_record_presence_validation
			hpp = Hospital.find_by name: "Hospital Pequeno Príncipe"
			if (self.medical_record.nil? && self.hospital == hpp) || (self.medical_record.strip.empty? && self.hospital == hpp)
				self.errors.add(:medical_record, "O prontuário médico não pode ficar em branco.")
			end
		end

		def medical_record_uniqueness_validation
			patients = Patient.find_by(hospital: self.hospital, medical_record: self.medical_record)
			if patients.size > 0
				self.errors.add(:medical_record, "O prontuário médico informado já está sendo utilizado.")
			end
		end









































	# # validates :medical_record, uniqueness: {scope: [:hospital], allow_blank: false}
	# validates :name, :birth_date, :hospital, presence: true
	# # validates :name, :birth_date, :mother_name, :medical_record, :hospital, presence: true
	# validates :name, uniqueness: {scope: [:birth_date, :mother_name, :hospital], allow_blank: true}
	# paginates_per 10
	# has_many :attendances
	# belongs_to :hospital
	# validate :validation_logic
	#
	# private
	#
	# 	def validation_logic
	# 		has_mother_name?
	# 		has_medical_record?
	# 		unique_logic_validation
	# 		puts "========================================"
	# 		p self.errors
	# 		puts "========================================"
	# 	end
	#
	# 	def has_mother_name?
	# 		hpp = Hospital.find_by name: "Hospital Pequeno Príncipe"
	# 		if self.mother_name.nil? && self.hospital == hpp
	# 			self.errors.add(:mother_name, "O nome da mãe não pode ficar em branco quando o Hospital selecionado for #{hpp.name}.")
	# 		end
	# 	end
	#
	# 	def has_medical_record?
	# 		hpp = Hospital.find_by name: "Hospital Pequeno Príncipe"
	# 		if self.medical_record.nil? && self.hospital == hpp
	# 			self.errors.add(:medical_record, "O prontuário médico não pode ficar em branco quando o Hospital selecionado for #{hpp.name}.")
	# 		end
	# 	end
	#
	# 	def unique_logic_validation
	# 		if self.name.empty? == false && self.birth_date && self.mother_name.empty? == false && self.hospital
	# 			patients = Patient.where("name = ? AND mother_name = ? AND birth_date = ? AND hospital_id = ?", self.name, self.mother_name, self.birth_date, self.hospital.id)
	# 			if patients.size > 1
	# 				self.errors.add(:name, ", nome da mãe, data de nascimento e hospital já estão cadastrados.")
	# 			end
	# 		end
	# 	end
	#






end
