class CreateProfessionalProfessionServices < ActiveRecord::Migration
  def change
    create_table :professional_profession_services do |t|
      t.integer :professional_profession_id
      t.integer :service_id
      t.integer :service_unit_id
      t.decimal :price
      t.boolean :active
      t.datetime :excluded_at

      t.timestamps null: false
    end
  end
end
