class ServiceProfessionalFeedback < ActiveRecord::Base
	has_one :user
	has_one :professional_service

	has_one :service, through: :professional_service
end
