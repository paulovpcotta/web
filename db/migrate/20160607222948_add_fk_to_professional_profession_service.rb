class AddFkToProfessionalProfessionService < ActiveRecord::Migration
  def change
	add_foreign_key :professional_profession_services, :professional_professions
	add_foreign_key :professional_profession_services, :services
	add_foreign_key :professional_profession_services, :service_units
  end
end
