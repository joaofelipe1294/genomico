class UserKind < ActiveRecord::Base
	validates :name, uniqueness: true
	validates :name, presence: true
	has_many :users

	def self.ADMIN
		UserKind.find_by name: 'admin'
	end

	def self.USER
		UserKind.find_by name: 'user'
	end

end
