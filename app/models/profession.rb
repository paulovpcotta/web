class Profession < ActiveRecord::Base

  belongs_to :category
	has_and_belongs_to_many :professionals
	
	validates_presence_of :name,:description
end
