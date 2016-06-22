class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :quantity_stars
      t.integer :source_feedback_id
      t.integer :user_id
      t.string :user_opnion
      t.boolean :active

      t.timestamps null: false
    end
  end
end
