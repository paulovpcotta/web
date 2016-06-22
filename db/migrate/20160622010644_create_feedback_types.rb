class CreateFeedbackTypes < ActiveRecord::Migration
  def change
    create_table :feedback_types do |t|
      t.string :name
      t.string :description
      t.boolean :active

      t.timestamps null: false
    end
  end
end
