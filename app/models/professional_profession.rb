class ProfessionalProfession < ActiveRecord::Base
	belongs_to :professional
	belongs_to :profession
	has_many :professional_profession_images, foreign_key: :professional_profession_id
	has_one :professional_profession_service
	has_one :source_feedback
	accepts_nested_attributes_for :professional_profession_images, allow_destroy: true


end
