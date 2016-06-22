class ChangingFeedbackStructure < ActiveRecord::Migration
  def change
	add_foreign_key :feedbacks, :source_feedbacks
	add_foreign_key :feedbacks, :users
	add_foreign_key :source_feedbacks, :professionals
	add_foreign_key :source_feedbacks, :professional_profession_services
	add_foreign_key :source_feedbacks, :professional_professions
	add_foreign_key :source_feedbacks, :feedback_types
	drop_table :service_professional_feedbacks
  end
end
