class UserKind < ActiveRecord::Base
	validates :name, uniqueness: true
	has_many :users
end
