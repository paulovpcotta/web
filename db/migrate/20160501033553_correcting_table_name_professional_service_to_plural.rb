class CorrectingTableNameProfessionalServiceToPlural < ActiveRecord::Migration
  def change
	rename_table :professional_service, :professional_services
  end
end
