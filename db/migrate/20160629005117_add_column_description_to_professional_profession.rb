class AddColumnDescriptionToProfessionalProfession < ActiveRecord::Migration
  def change
	add_column :professional_professions, :description, :string
  end
end
