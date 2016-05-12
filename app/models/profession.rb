class Profession < ActiveRecord::Base

	has_and_belongs_to_many :professionals
	
	validates_presence_of :name,:description
end
