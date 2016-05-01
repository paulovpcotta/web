class CorrectingIndexes < ActiveRecord::Migration
  def change
	add_foreign_key :addresses, :cities
	remove_foreign_key :professional_city_coverages, :professionals
	remove_foreign_key :professional_district_coverages, :professionals
	add_foreign_key :professional_city_coverages, :professionals
	add_foreign_key :professional_district_coverages, :professionals
	add_foreign_key :professional_service, :professionals
	add_foreign_key :professionals, :users
	add_foreign_key :professionals, :phones	
	add_foreign_key :professionals, :addresses
	add_foreign_key :professional_profession_images, :professional_professions
	add_foreign_key :professional_professions, :professionals
	add_foreign_key :professional_professions, :professions
	add_foreign_key :service_professional_feedbacks, :professional_service
	add_foreign_key :service_professional_feedbacks, :users
	add_foreign_key :users, :phones
  end
end
