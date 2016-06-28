class CreateSourceFeedbacks < ActiveRecord::Migration
  def change
    create_table :source_feedbacks do |t|
      t.integer :professional_id
      t.integer :professional_profession_id
      t.integer :professional_profession_service_id
      t.integer :feedback_type_id

      t.timestamps null: false
    end
  end
end
