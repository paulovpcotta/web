class ProfessionalServiceToProfessionalProfessionServiceFromServiceProfessionalFeedaback < ActiveRecord::Migration
  def change
	remove_foreign_key :service_professional_feedbacks, :professional_services
	rename_column :service_professional_feedbacks, :professional_service_id, :professional_profession_service_id
	add_foreign_key :service_professional_feedbacks, :professional_profession_services
  end
end
