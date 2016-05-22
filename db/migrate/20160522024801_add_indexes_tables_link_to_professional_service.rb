class AddIndexesTablesLinkToProfessionalService < ActiveRecord::Migration
  def change
	add_index :professional_services, ["active"] 
	add_index :professional_services, ["active", "service_id"], :name => 'idx_active_service'
	add_index :professional_services, ["active", "service_id", "professional_id"], :name => 'idx_active_service_professional'
	add_index :professional_services, ["service_id", "professional_id"], :name => 'idx_service_professional'
	add_index :professional_services, ["excluded_at"]
	add_index :professional_services, ["created_at"]

	add_index :services, ["active"]
	add_index :services, ["active", "category_id"]
	add_index :services, ["created_at"]

	add_index :categories, ["active"]

	add_index :cities, ["active"]

	add_index :districts, ["active"]

	add_index :professional_city_coverages, ["city_id", "professional_id"], :name => 'idx_city_professional'
	add_index :professional_city_coverages, ["created_at"]

	add_index :professional_district_coverages, ["district_id", "professional_id"], :name => 'idx_district_professional'
	add_index :professional_district_coverages, ["created_at"]

	add_index :professionals, ["active"]
	add_index :professionals, ["active", "user_id"], :name => 'idx_active_user'
	add_index :professionals, ["active", "address_id"], :name => 'idx_active_address'
	add_index :professionals, ["active", "phone_id"], :name => 'idx_active_phone'
	add_index :professionals, ["created_at"]

	add_index :professions, ["active"]	
  end

end
