class Field < ActiveRecord::Base
	validates :name, uniqueness: true
end
