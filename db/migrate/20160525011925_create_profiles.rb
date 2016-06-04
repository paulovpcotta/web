class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.attachment :avatar

      t.timestamps null: false
    end
  end
end
