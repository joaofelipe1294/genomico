class UserKind < ActiveRecord::Base
	validates :name, uniqueness: true
end
