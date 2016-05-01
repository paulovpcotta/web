class RenameColunaServiceAdIdToProfessionalId < ActiveRecord::Migration
  def change
	remove_foreign_key :professional_district_coverages, :service_ads
	rename_column :professional_district_coverages, :service_ad_id, :professional_id
  end
end
