class AddRelationshipFromTableProfessionsTowardsCategories < ActiveRecord::Migration
  def change
	add_column :professions, :category_id, :integer
	add_foreign_key :professions, :categories
  end
end
