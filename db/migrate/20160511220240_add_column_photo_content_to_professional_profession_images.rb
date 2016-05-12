class AddColumnPhotoContentToProfessionalProfessionImages < ActiveRecord::Migration
  def change
	add_column :professional_profession_images, :photo_content, :text
  end
end
