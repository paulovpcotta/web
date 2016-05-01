class RenameColumnServiceAdIdToProfessionalId < ActiveRecord::Migration
  def change
	remove_foreign_key :professional_city_coverages, :service_ads
	rename_column :professional_city_coverages, :service_ad_id, :professional_id
  end
end
