class ProfessionalProfession < ActiveRecord::Base
	belongs_to :professional
	# has_one :profession
	has_many :professional_profession_images, foreign_key: :professional_profession_id
end
