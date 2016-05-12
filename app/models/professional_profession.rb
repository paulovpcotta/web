class ProfessionalProfession < ActiveRecord::Base
	# has_one :professional
	# has_one :profession
	has_many :professional_profession_images, foreign_key: :professional_profession_id
end
